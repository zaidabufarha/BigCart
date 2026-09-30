import 'dotenv/config';
import fs from 'fs';
import path from 'path';
import { PrismaClient } from './generated/prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';

import { Pool } from 'pg';

// Aiven signs the database's certificate with its own project CA, which no
// system trusts by default. Passing that CA (public, so it lives in the repo)
// lets the connection verify it's really talking to our database.
//
// sslmode comes off the URL because pg lets the URL's SSL settings replace
// the `ssl` option below; with it left on, the CA would be ignored.
const url = new URL(process.env.DATABASE_URL!);
url.searchParams.delete('sslmode');

const pool = new Pool({
  connectionString: url.toString(),
  ssl: {
    ca: fs.readFileSync(path.join(__dirname, '..', 'ca.pem'), 'utf8'),
  },
});

const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

export default prisma;
