/**
 * ローカライズされた版を locale 指定で解決する入口。
 *
 * 採番・参照解決・ノート配置の実装を複製しない。選択した locale の既存
 * `RevisionSnapshot` を `resolve` / `resolveTolerantly` へそのまま渡し、解決済み
 * 文書へロケール文脈だけを付加する。
 */

import { err, ok, type Result } from '../result.ts'
import { localeRuntimeSchema, type Locale } from '../structured-text/locale.ts'
import {
  availableLocalesOf,
  type LocalizationAllowances,
  type LocalizedRevisionSnapshot,
  type LocalizationValidationError,
  type MissingTranslationError,
  validateLocalizedRevision,
} from './localized-revision.ts'
import {
  resolve,
  resolveTolerantly,
  type ResolveError,
  type ResolveOptions,
  type Resolution,
} from './resolve.ts'
import type { ResolvedDocument } from './resolved-document.ts'

export type LocalizedResolvedDocument = ResolvedDocument & {
  sourceLocale: Locale
  locale: Locale
  availableLocales: readonly Locale[]
  translatedFrom: Locale | null
  translatedFromRevision: number | null
}

export type LocalizedResolution = Omit<Resolution, 'document'> & {
  document: LocalizedResolvedDocument
}

export type LocalizedResolveError = LocalizationValidationError | MissingTranslationError | ResolveError

/** 公開 API の要求 locale も、ローカライゼーション集約と同じ値域で検査する。 */
const validateRequestedLocale = (locale: string): Result<Locale, LocalizationValidationError> => {
  const parsed = localeRuntimeSchema.safeParse(locale)
  return parsed.success
    ? ok(parsed.data)
    : err({
        code: 'localization_validation_error',
        issues: parsed.error.issues.map((issue) => ({ path: 'locale', message: issue.message })),
      })
}

const selectRevision = <L extends string, M>(
  localized: LocalizedRevisionSnapshot<L, M>,
  locale: Locale,
): Result<
  {
    revision: LocalizedRevisionSnapshot<L, M>['localizations'][number]['revision']
    translatedFrom: Locale | null
    translatedFromRevision: number | null
    availableLocales: readonly Locale[]
  },
  MissingTranslationError
> => {
  const availableLocales = availableLocalesOf(localized)
  const entry = localized.localizations.find((candidate) => candidate.locale === locale)
  return entry === undefined
    ? err({ code: 'missing_translation', locale, availableLocales })
    : ok({
        revision: entry.revision,
        translatedFrom: entry.translatedFrom,
        translatedFromRevision: entry.translatedFromRevision,
        availableLocales,
      })
}

const withLocale = (
  document: ResolvedDocument,
  sourceLocale: Locale,
  locale: Locale,
  translatedFrom: Locale | null,
  translatedFromRevision: number | null,
  availableLocales: readonly Locale[],
): LocalizedResolvedDocument => ({
  ...document,
  sourceLocale,
  locale,
  translatedFrom,
  translatedFromRevision,
  availableLocales,
})

/**
 * 厳格なローカライズ解決。ローカライズ集約の不変条件も、選択した locale 内の
 * 参照・採番不変条件も満たす場合にだけ解決済み文書を返す。
 */
export const resolveLocalized = <L extends string, M>(
  localized: LocalizedRevisionSnapshot<L, M>,
  locale: Locale,
  options: ResolveOptions,
  allowances: LocalizationAllowances = {},
): Result<LocalizedResolvedDocument, LocalizedResolveError> => {
  const requestedLocale = validateRequestedLocale(locale)
  if (!requestedLocale.success) return err(requestedLocale.error)
  const validated = validateLocalizedRevision(localized, allowances)
  if (!validated.success) return err(validated.error)
  const selected = selectRevision(localized, requestedLocale.data)
  if (!selected.success) return err(selected.error)
  const resolved = resolve(selected.data.revision, options)
  if (!resolved.success) return err(resolved.error)
  return ok(
    withLocale(
      resolved.data,
      localized.sourceLocale,
      requestedLocale.data,
      selected.data.translatedFrom,
      selected.data.translatedFromRevision,
      selected.data.availableLocales,
    ),
  )
}

/**
 * 寛容なローカライズ解決。
 *
 * locale 集約自体が壊れている、または要求 locale が無い場合は比較基準・入力が決まらない
 * ので Result のエラーにする。集約が正しければ、選択された文書内の不備については既存の
 * `resolveTolerantly` と同じく文書と diagnostics を必ず返す。
 */
export const resolveLocalizedTolerantly = <L extends string, M>(
  localized: LocalizedRevisionSnapshot<L, M>,
  locale: Locale,
  options: ResolveOptions,
  allowances: LocalizationAllowances = {},
): Result<LocalizedResolution, LocalizationValidationError | MissingTranslationError> => {
  const requestedLocale = validateRequestedLocale(locale)
  if (!requestedLocale.success) return err(requestedLocale.error)
  const validated = validateLocalizedRevision(localized, allowances)
  if (!validated.success) return err(validated.error)
  const selected = selectRevision(localized, requestedLocale.data)
  if (!selected.success) return err(selected.error)
  const resolution = resolveTolerantly(selected.data.revision, options)
  return ok({
    ...resolution,
    document: withLocale(
      resolution.document,
      localized.sourceLocale,
      requestedLocale.data,
      selected.data.translatedFrom,
      selected.data.translatedFromRevision,
      selected.data.availableLocales,
    ),
  })
}
