import { describe, it, expect, beforeEach, vi } from 'vitest';
import request from 'supertest';

// Google's verifier is replaced, so these tests never call Google: each test
// decides what a "verified" token contains, or that verification fails.
const { verifyIdToken } = vi.hoisted(() => ({ verifyIdToken: vi.fn() }));
vi.mock('google-auth-library', () => ({
  OAuth2Client: vi.fn().mockImplementation(() => ({ verifyIdToken })),
}));

import app from '../src/app';
import prisma from '../src/prisma';

const googleUser = (overrides: object = {}) => ({
  sub: 'google-123',
  email: 'person@gmail.com',
  email_verified: true,
  name: 'Person',
  picture: 'https://lh3.googleusercontent.com/a/photo',
  ...overrides,
});

const dbUser = (overrides: object = {}) => ({
  id: 7,
  email: 'person@gmail.com',
  phone: '',
  name: 'Person',
  image_path: 'https://lh3.googleusercontent.com/a/photo',
  google_id: 'google-123',
  notification_preference: { id: 1, user_id: 7, allow_general: true, allow_order: true, allow_email: true },
  address: [],
  credit_card: [],
  order: [],
  transaction: [],
  favorite: [],
  ...overrides,
});

const signIn = () =>
  request(app)
    .post('/graphql')
    .send({ query: 'mutation { googleSignIn(idToken: "any") { token user { id email phone } } }' });

describe('googleSignIn mutation', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('rejects a token Google does not verify', async () => {
    verifyIdToken.mockRejectedValue(new Error('Invalid token signature'));

    const res = await signIn();

    expect(res.body.errors[0].message).toContain('Google sign-in failed');
    expect(prisma.user.create).not.toHaveBeenCalled();
  });

  it('rejects an account whose email Google has not verified', async () => {
    verifyIdToken.mockResolvedValue({ getPayload: () => googleUser({ email_verified: false }) });

    const res = await signIn();

    expect(res.body.errors[0].message).toContain('Google sign-in failed');
  });

  it('signs in an account already linked to this Google id', async () => {
    verifyIdToken.mockResolvedValue({ getPayload: () => googleUser() });
    (prisma.user.findUnique as any).mockResolvedValueOnce(dbUser());

    const res = await signIn();

    expect(res.body.errors).toBeUndefined();
    expect(res.body.data.googleSignIn.token).toBeDefined();
    expect(prisma.user.create).not.toHaveBeenCalled();
    expect(prisma.user.update).not.toHaveBeenCalled();
  });

  it('links an existing password account with the same email', async () => {
    verifyIdToken.mockResolvedValue({ getPayload: () => googleUser() });
    (prisma.user.findUnique as any)
      .mockResolvedValueOnce(null) // no account with this Google id
      .mockResolvedValueOnce(dbUser({ google_id: null, phone: '+962791234567' })); // but one with the email
    (prisma.user.update as any).mockResolvedValue(dbUser({ phone: '+962791234567' }));

    const res = await signIn();

    expect(res.body.errors).toBeUndefined();
    expect(prisma.user.update).toHaveBeenCalledWith(
      expect.objectContaining({ where: { id: 7 }, data: { google_id: 'google-123' } }),
    );
    expect(res.body.data.googleSignIn.user.phone).toBe('+962791234567');
  });

  it('creates a new account with no phone number', async () => {
    verifyIdToken.mockResolvedValue({ getPayload: () => googleUser() });
    (prisma.user.findUnique as any).mockResolvedValue(null);
    (prisma.user.create as any).mockResolvedValue(dbUser());

    const res = await signIn();

    expect(res.body.errors).toBeUndefined();
    const { data } = (prisma.user.create as any).mock.calls[0][0];
    expect(data).toMatchObject({ email: 'person@gmail.com', google_id: 'google-123', phone: '' });
    expect(res.body.data.googleSignIn.token).toBeDefined();
  });
});
