import jwt from 'jsonwebtoken';
import { Response, NextFunction } from 'express';
import { AuthRequest } from '../types/auth-request';

//instead of throwing I'll use flags. this way I can ignore it for signup and login

const isAuth = (req: AuthRequest, res: Response, next: NextFunction) => {
    try {
        const authHeader = req.get('Authorization');
        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            req.isAuth = false;
            return next();
        }
        const token = authHeader.split(' ')[1]; //after 'Bearer '
        // our tokens are signed as { userId } (see logIn); verify throws for
        // a bad or expired one, which the catch below turns into "not signed in"
        const decodedToken = jwt.verify(token, process.env.JWT_SECRET!) as jwt.JwtPayload & { userId: number };
        if (decodedToken) {
            req.id = decodedToken.userId;
            req.isAuth = true;
            return next();
        }
        else {
            req.isAuth = false;
            return next();
        }

    }
    catch (err) {
        req.isAuth = false;
        return next();
    }
};

export default isAuth;