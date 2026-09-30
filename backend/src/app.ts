import 'dotenv/config'
import express from 'express'
import { graphqlHTTP } from 'express-graphql'
import bodyParser from 'body-parser'
import graphqlSchema from './graphql/schema'
import graphqlResolver from './graphql/resolvers'
import isAuth from './middleware/is-auth'
import { GraphQLError } from 'graphql'
import { HttpError } from './types/error'

const requiredEnvVars = ['JWT_SECRET', 'DATABASE_URL', 'RESEND_API_KEY'];
for (const envVar of requiredEnvVars) {
    if (!process.env[envVar]) {
        throw new Error(`Missing required environment variable: ${envVar}`);
    }
}

const app = express()

app.use(bodyParser.json())

// Browsers only let a page call this API if its site is allowed here: the
// live web client, and local development (Vite, and the CI browser test).
// CORS only applies to browsers, so the Flutter app needs no entry.
const ALLOWED_ORIGINS = ['https://big-cart-eight.vercel.app', 'http://localhost:5173']

app.use((req: any, res: any, next: any) => {
    const origin = req.headers.origin
    if (ALLOWED_ORIGINS.includes(origin)) {
        res.setHeader('Access-Control-Allow-Origin', origin)
    }
    // the answer depends on the Origin header, so caches must keep them apart
    res.setHeader('Vary', 'Origin')
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,PATCH,DELETE')
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
    if (req.method === 'OPTIONS') { //this simplifies communication with clients
        return res.sendStatus(200)
    }
    next()
})

app.use(isAuth)

// The commit this server was deployed from (Render sets RENDER_GIT_COMMIT).
// CI waits for it to match the pushed commit before the browser test runs.
app.get('/version', (req: any, res: any) => {
    res.json({ commit: process.env.RENDER_GIT_COMMIT ?? null })
})

app.use('/graphql', graphqlHTTP((req, res) => ({
    schema: graphqlSchema,
    rootValue: graphqlResolver,
    graphiql: false,
    // Resolvers throw errors with a statusCode, and sometimes a code. Left
    // alone, express-graphql sends every failed request as HTTP 500 and drops
    // both. This sends the error's own status and puts both in extensions,
    // where the clients read them.
    customFormatErrorFn: (error: GraphQLError) => {
        const original = error.originalError as HttpError | undefined;
        // express-graphql has already set 500 for a request that produced no
        // data; the first error with a status of its own replaces it
        if (res.statusCode === 500 && original?.statusCode) {
            res.statusCode = original.statusCode;
        }
        // An error thrown without a statusCode is one nobody planned for (a
        // bug, a database failure). Its message can hold internals like table
        // names, so it's logged here and the client gets a generic one.
        // Errors with no originalError are GraphQL's own (a malformed query)
        // and keep their message.
        const unexpected = original !== undefined && original.statusCode === undefined;
        if (unexpected) console.error(original);
        return {
            message: unexpected ? 'Something went wrong. Please try again.' : error.message,
            locations: error.locations,
            path: error.path,
            extensions: {
                status: original?.statusCode ?? (unexpected ? 500 : 400),
                ...(original?.code && { code: original.code }),
            },
        };
    },
})))
if (process.env.NODE_ENV !== 'test') {
    app.listen(process.env.PORT || 4321)
}

export default app;