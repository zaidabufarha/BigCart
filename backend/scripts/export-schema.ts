import { printSchema } from 'graphql'
import { writeFileSync } from 'fs'
import { join } from 'path'
import schema from '../src/graphql/schema'

// The schema lives as a template string inside buildSchema(), so there's no .graphql
// file for tooling to read. Print it for both clients' codegen: the web reads it from
// here, and Flutter needs its own copy inside the package (build_runner can't read
// files outside it).
const sdl = printSchema(schema)
const outputs = [
  join(__dirname, '..', 'schema.graphql'),
  join(__dirname, '..', '..', 'mobile_frontend', 'lib', 'core', 'graphql', 'schema.graphql'),
]
for (const out of outputs) {
  writeFileSync(out, sdl)
  console.log('wrote', out)
}
