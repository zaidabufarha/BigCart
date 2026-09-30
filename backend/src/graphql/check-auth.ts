import { AuthRequest } from '../types/auth-request';
import { HttpError } from '../types/error';

// Every resolver that needs a signed-in user calls this first. is-auth has
// already checked the token, so no valid token means no session. The code
// tells the clients to sign out, unlike other 401s such as a wrong password.
export default function checkAuth(req: AuthRequest) {
    if (!req.isAuth) {
        const err: HttpError = new Error('Not authorized');
        err.statusCode = 401;
        err.code = 'UNAUTHENTICATED';
        throw err;
    }
}
