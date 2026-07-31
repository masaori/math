/**
 * storage 宣言と SSOT の突合（docs/architecture-overview.md）。
 *
 * 「明示宣言のみを正とし、既定で暗黙に埋めない。不明 entity・重複宣言・抜け漏れをすべて
 * エラーにする」という resolver の共通方針を実装する。生成の前段でここを通し、
 * 抜け漏れ・曖昧をこの段で落としてから生成へ入る。
 */

import type { EntityDefinition } from '@masaori/zod-to-entity-definitions'

import { err, ok, type Result } from '../../domain-model/result.ts'
import type { EntityStorage, StorageBackend } from '../config/storage.ts'

export type StorageResolutionError =
  | { code: 'undeclared_entity'; entities: readonly string[] }
  | { code: 'unknown_entity'; entities: readonly string[] }
  | { code: 'duplicate_declaration'; entities: readonly string[] }

export type ResolvedStorage = Readonly<Record<string, StorageBackend>>

export const resolveStorage = (
  definitions: readonly EntityDefinition[],
  assignments: readonly EntityStorage[],
): Result<ResolvedStorage, StorageResolutionError> => {
  const known = new Set(definitions.map((definition) => definition.name))

  const seen = new Set<string>()
  const duplicated: string[] = []
  const unknown: string[] = []
  const resolved: Record<string, StorageBackend> = {}

  for (const assignment of assignments) {
    if (seen.has(assignment.entity)) duplicated.push(assignment.entity)
    seen.add(assignment.entity)
    if (!known.has(assignment.entity)) unknown.push(assignment.entity)
    resolved[assignment.entity] = assignment.backend
  }
  if (duplicated.length > 0) return err({ code: 'duplicate_declaration', entities: duplicated })
  if (unknown.length > 0) return err({ code: 'unknown_entity', entities: unknown })

  const undeclared = [...known].filter((name) => !seen.has(name))
  if (undeclared.length > 0) return err({ code: 'undeclared_entity', entities: undeclared })

  return ok(resolved)
}
