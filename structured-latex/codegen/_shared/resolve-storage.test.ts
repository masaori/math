import assert from 'node:assert/strict'
import { test } from 'node:test'

import { generateEntities } from '@masaori/zod-to-entity-definitions'

import { allEntities } from '../../domain-model/entities/index.ts'
import { storageAssignments } from '../config/storage.ts'
import { resolveStorage } from './resolve-storage.ts'

const definitions = generateEntities(allEntities)

test('現在の storage 宣言は SSOT の全 entity を過不足なく覆っている', () => {
  const result = resolveStorage(definitions, storageAssignments)
  assert.equal(result.success, true)
})

test('宣言漏れはエラーになる（書き忘れを静かに通さない）', () => {
  const result = resolveStorage(
    definitions,
    storageAssignments.filter((assignment) => assignment.entity !== 'Segment'),
  )
  assert.deepEqual(result, {
    success: false,
    error: { code: 'undeclared_entity', entities: ['Segment'] },
  })
})

test('SSOT に無い entity の宣言はエラーになる', () => {
  const result = resolveStorage(definitions, [
    ...storageAssignments,
    { entity: 'Ghost', backend: 'cloud-sql' },
  ])
  assert.deepEqual(result, { success: false, error: { code: 'unknown_entity', entities: ['Ghost'] } })
})

test('重複宣言はエラーになる', () => {
  const result = resolveStorage(definitions, [
    ...storageAssignments,
    { entity: 'Document', backend: 'in-memory' },
  ])
  assert.deepEqual(result, {
    success: false,
    error: { code: 'duplicate_declaration', entities: ['Document'] },
  })
})

test('認可の主体は永続化しない投影として宣言されている', () => {
  const result = resolveStorage(definitions, storageAssignments)
  assert.equal(result.success && result.data['Requester'], 'projected')
})
