import prisma from '../../prisma';
import { AuthRequest } from '../../types/auth-request';
import { Resend } from 'resend';
import crypto from 'crypto';
const bcrypt = require('bcryptjs')
const fs = require('fs')
const jwt = require('jsonwebtoken')
const validator = require('validator')
import { HttpError } from '../../types/error';
import { OAuth2Client } from 'google-auth-library';

const resend = new Resend(process.env.RESEND_API_KEY);

// The BigCart web OAuth client's ID. Not a secret: it ships in both clients.
// The web app and the Flutter app both ask Google for ID tokens addressed to
// it, so this is the one audience the backend accepts.
const GOOGLE_CLIENT_ID = '224693958509-p3kik94g234eh37hom8gufrvdumlsv6v.apps.googleusercontent.com';
const googleClient = new OAuth2Client();


function checkAuth(req: any) { //cleanest code of all time ever
    if (!req.isAuth) {
        const err: HttpError = new Error('Not authorized')
        err.statusCode = 401
        throw err
    }
}

function formatTransaction(t: any) {
    if (!t) return t;
    return {
        ...t,
        created_at: t.created_at ? new Date(t.created_at).toISOString() : t.created_at
    };
}

function formatOrder(o: any) {
    if (!o) return o;
    return {
        ...o,
        date_placed: o.date_placed ? new Date(o.date_placed).toISOString() : o.date_placed,
        date_confirmed: o.date_confirmed ? new Date(o.date_confirmed).toISOString() : null,
        date_shipped: o.date_shipped ? new Date(o.date_shipped).toISOString() : null,
        date_out_for_delivery: o.date_out_for_delivery ? new Date(o.date_out_for_delivery).toISOString() : null,
        date_delivered: o.date_delivered ? new Date(o.date_delivered).toISOString() : null,
        order_item: (o.order_item || []).map((oi: any) => ({
            ...oi,
            product: oi.product ? {
                ...oi.product,
                color: oi.product.color.toString(),
                category: oi.product.category ? {
                    ...oi.product.category,
                    color: oi.product.category.color.toString()
                } : undefined,
                is_favorite: false
            } : oi.product
        })),
        transaction: (o.transaction || []).map(formatTransaction)
    };
}

function formatUser(user: any) {
    if (!user) return user;
    return {
        ...user,
        order: (user.order || []).map(formatOrder),
        transaction: (user.transaction || []).map(formatTransaction),
        favorite: (user.favorite || []).map((f: any) => ({
            ...f.product,
            color: f.product.color.toString(),
            category: f.product.category ? {
                ...f.product.category,
                color: f.product.category.color.toString()
            } : undefined,
            is_favorite: true
        }))
    };
}

// Everything the AuthPayload's user carries, loaded in one query. Shared by
// logIn and googleSignIn so both return the same shape.
const FULL_USER = {
    notification_preference: true,
    address: true,
    credit_card: true,
    order: {
        include: {
            order_item: {
                include: {
                    product: {
                        include: {
                            category: true
                        }
                    }
                }
            },
            address: true,
            credit_card: true,
            transaction: true
        }
    },
    transaction: true,
    favorite: {
        include: {
            product: {
                include: {
                    category: true
                }
            }
        }
    }
} as const;

export default {
    signUp: async function ({ email, number, password }: { email: string, number: string, password: string }, req: any) {
        email = email.trim().toLowerCase();
        number = number.trim();
        if (await prisma.user.findUnique({
            where: { email: email }
        })) {
            const err: HttpError = new Error('Email already in use. Try logging in if it\'s your email.')
            err.statusCode = 422
            throw err
        }
        if (!validator.isEmail(email)) {
            const err: HttpError = new Error('Invalid email')
            err.statusCode = 422
            throw err
        }
        else if (!validator.isLength(password, { min: 8, max: 72 })) {
            const err: HttpError = new Error('Password must be between 8 and 72 characters')
            err.statusCode = 422
            throw err
        }
        //now we know we have valid input and a unique email
        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = await prisma.user.create({
            data: {
                email: email,
                phone: number,
                password: hashedPassword,
                name: 'User',
                image_path: 'assets/blank_profile_picture.png',
                notification_preference: {
                    create: {}
                }
            },
            include: {
                notification_preference: true,
                address: true,
                credit_card: true,
                order: true,
                transaction: true,
                favorite: {
                    include: {
                        product: {
                            include: {
                                category: true
                            }
                        }
                    }
                }
            }
        });
        return formatUser(newUser);
    },

    logIn: async function ({ email, password }: { email: string, password: string }, req: any) {
        email = email.trim().toLowerCase();
        try {
            const user = await prisma.user.findUnique({
                where: { email: email },
                include: FULL_USER
            });
            if (user) {
                if (await bcrypt.compare(password, user.password)) {
                    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, { expiresIn: '1d' });
                    return { token: token, user: formatUser(user) };
                }
                else {
                    const err: HttpError = new Error('Incorrect password')
                    err.statusCode = 401
                    throw err
                }
            }
            else {
                const err: HttpError = new Error('User not found, check the email and try again.')
                err.statusCode = 404
                throw err
            }
        }
        catch (err: any) {
            if (!err.statusCode) {
                err.statusCode = 500
            }
            throw err
        }
    },
    // Sign in (or up) with Google. The client gets an ID token from Google — a
    // JWT Google signs, holding the account's email and a stable id ("sub") —
    // and hands it here. We verify it, match it to a user, and return the same
    // token + user as logIn, so the clients treat both logins identically.
    googleSignIn: async function ({ idToken }: { idToken: string }) {
        // 1. Is it genuinely from Google, issued for BigCart, and unexpired?
        //    verifyIdToken checks the signature against Google's public keys,
        //    the audience against our client id, and the expiry.
        let payload;
        try {
            const ticket = await googleClient.verifyIdToken({ idToken, audience: GOOGLE_CLIENT_ID });
            payload = ticket.getPayload();
        } catch {
            payload = undefined;
        }
        // an unverified email could belong to someone else — never link on it
        if (!payload?.sub || !payload.email || !payload.email_verified) {
            const err: HttpError = new Error('Google sign-in failed. Please try again.');
            err.statusCode = 401;
            throw err;
        }
        const googleId = payload.sub;
        const email = payload.email.toLowerCase();

        // 2. An account already linked to this Google account…
        let user = await prisma.user.findUnique({ where: { google_id: googleId }, include: FULL_USER });

        // …or a password account with the same email: link it, so the person
        //    keeps their cart, orders and addresses
        if (!user) {
            const byEmail = await prisma.user.findUnique({ where: { email }, include: FULL_USER });
            if (byEmail) {
                user = await prisma.user.update({
                    where: { id: byEmail.id },
                    data: { google_id: googleId },
                    include: FULL_USER
                });
            }
        }

        // 3. …or a brand-new account. Google gives no phone number, so it starts
        //    empty (addable in the profile); the password is random and unknown,
        //    settable later through Forgot password.
        if (!user) {
            user = await prisma.user.create({
                data: {
                    email,
                    google_id: googleId,
                    name: payload.name ?? 'User',
                    phone: '',
                    password: await bcrypt.hash(crypto.randomBytes(32).toString('hex'), 10),
                    image_path: payload.picture ?? 'assets/blank_profile_picture.png',
                    notification_preference: { create: {} }
                },
                include: FULL_USER
            });
        }

        // 4. Our own session token, exactly like logIn
        const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, { expiresIn: '1d' });
        return { token, user: formatUser(user) };
    },
    forgotPassword: async function ({ email }: { email: string }, req: any) {
        email = email.trim().toLowerCase();
        if (!validator.isEmail(email)) {
            const err: HttpError = new Error('Invalid email address');
            err.statusCode = 422;
            throw err;
        }
        const user = await prisma.user.findUnique({
            where: { email: email }
        });
        if (!user) {
            const err: HttpError = new Error('No account found with this email');
            err.statusCode = 404;
            throw err;
        }

        const tempPassword = 'Temp_' + crypto.randomBytes(3).toString('hex') + '9!';
        const hashedPassword = await bcrypt.hash(tempPassword, 10);

        await prisma.user.update({
            where: { email: email },
            data: { password: hashedPassword }
        });

        await resend.emails.send({
            from: 'BigCart <onboarding@resend.dev>',
            to: email,
            subject: 'Your Temporary BigCart Password',
            html: `
                <h2>BigCart Password Reset</h2>
                <p>Hello <strong>${user.name}</strong>,</p>
                <p>Your temporary password is:</p>
                <h3 style="background:#f4f4f4;padding:10px 15px;display:inline-block;border-radius:6px;font-family:monospace;letter-spacing:1px;">${tempPassword}</h3>
                <p>You can use this password to log in immediately. You can update it anytime in your Profile under <em>About me</em>.</p>
            `
        });

        return true;
    },
    changePassword: async function ({ oldPassword, newPassword }: { oldPassword: string, newPassword: string }, req: AuthRequest) {
        checkAuth(req);
        if (!validator.isLength(newPassword, { min: 8, max: 72 })) {
            const err: HttpError = new Error('Password must be between 8 and 72 characters');
            err.statusCode = 422;
            throw err;
        }
        const user = await prisma.user.findUnique({
            where: { id: req.id! }
        });
        if (!user) {
            const err: HttpError = new Error('User does not exist');
            err.statusCode = 404;
            throw err;
        }
        const isEqual = await bcrypt.compare(oldPassword, user.password);
        if (!isEqual) {
            const err: HttpError = new Error('Incorrect current password');
            err.statusCode = 401;
            throw err;
        }
        const hashedPassword = await bcrypt.hash(newPassword, 10);
        await prisma.user.update({
            where: { id: req.id! },
            data: { password: hashedPassword }
        });
        return true;
    }
};