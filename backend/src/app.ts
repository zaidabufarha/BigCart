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

app.use((req: any, res: any, next: any) => {
    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,PATCH,DELETE')
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
    if (req.method === 'OPTIONS') { //this simplifies communication with clients
        return res.sendStatus(200)
    }
    next()
})

app.use(isAuth)

app.use('/graphql', graphqlHTTP((req, res) => ({
    schema: graphqlSchema,
    rootValue: graphqlResolver,
    graphiql: true,
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
        return {
            message: error.message,
            locations: error.locations,
            path: error.path,
            extensions: {
                status: original?.statusCode ?? 500,
                ...(original?.code && { code: original.code }),
            },
        };
    },
})))
if (process.env.NODE_ENV !== 'test') {
    app.listen(process.env.PORT || 4321)
}

export default app;