/**
 * プロジェクトが宣言する翻訳ソースの読み込み。
 *
 * `content/` / `notes/` は常に原文ロケールであり、設定が無い既存プロジェクトは
 * 暗黙に日本語だけを持つ。翻訳を追加するプロジェクトだけが `locales.config.ts` を
 * 置き、翻訳の入力ディレクトリと翻訳元を明示する。
 */

import { existsSync } from 'node:fs'
import { join, relative } from 'node:path'
import { pathToFileURL } from 'node:url'

import type { LocalizationAllowance } from '../../domain-model/resolved/localized-revision.ts'
import type { Locale } from '../../domain-model/structured-text/locale.ts'

export type TranslationSource = {
  locale: Locale
  translatedFrom: Locale
  /** プロジェクト root からの相対パス。 */
  contentDir: string
  /** 省略時は翻訳ノート無し。 */
  notesDir?: string
  /**
   * 原文と一致しない差のうち、このプロジェクトが**理由つきで**認めるもの。
   *
   * 省略時は一切の差を認めない（既定は I8 の厳格な構造一致）。宣言しても、
   * 宣言した規則で説明できない差が 1 件でも残れば違反になる。
   */
  allowance?: LocalizationAllowance
}

export type ProjectLocalizationConfig = {
  sourceLocale: Locale
  translations: readonly TranslationSource[]
}

export const LEGACY_JAPANESE_LOCALIZATION: ProjectLocalizationConfig = {
  sourceLocale: 'ja',
  translations: [],
}

const isRelativeDirectory = (value: unknown): value is string =>
  typeof value === 'string' && value.length > 0 && !value.startsWith('/') && !value.split('/').includes('..')

const invalid = (message: string): never => {
  throw new TypeError(`locales.config.ts が不正: ${message}`)
}

const parseConfig = (value: unknown): ProjectLocalizationConfig => {
  if (typeof value !== 'object' || value === null || Array.isArray(value)) invalid('オブジェクトでなければならない')
  const config = value as { sourceLocale?: unknown; translations?: unknown }
  const sourceLocale = config.sourceLocale
  const translations = config.translations
  if (typeof sourceLocale !== 'string' || sourceLocale.length === 0) {
    invalid('sourceLocale は空でない文字列でなければならない')
  }
  if (!Array.isArray(translations)) invalid('translations は配列でなければならない')
  const parsedSourceLocale = sourceLocale as string
  const parsedTranslations = translations as unknown[]
  return {
    sourceLocale: parsedSourceLocale,
    translations: parsedTranslations.map((translation, index): TranslationSource => {
      if (typeof translation !== 'object' || translation === null || Array.isArray(translation)) {
        invalid(`translations[${index}] はオブジェクトでなければならない`)
      }
      const entry = translation as Record<string, unknown>
      const locale = entry.locale
      const translatedFrom = entry.translatedFrom
      const contentDir = entry.contentDir
      const notesDir = entry.notesDir
      const allowance = entry.allowance
      if (typeof locale !== 'string' || locale.length === 0) {
        invalid(`translations[${index}].locale は空でない文字列でなければならない`)
      }
      if (typeof translatedFrom !== 'string' || translatedFrom.length === 0) {
        invalid(`translations[${index}].translatedFrom は空でない文字列でなければならない`)
      }
      if (!isRelativeDirectory(contentDir)) {
        invalid(`translations[${index}].contentDir は project root 配下の相対パスでなければならない`)
      }
      if (notesDir !== undefined && !isRelativeDirectory(notesDir)) {
        invalid(`translations[${index}].notesDir は project root 配下の相対パスでなければならない`)
      }
      if (allowance !== undefined) {
        if (typeof allowance !== 'object' || allowance === null || Array.isArray(allowance)) {
          invalid(`translations[${index}].allowance はオブジェクトでなければならない`)
        }
        const declared = allowance as { localeSpecificMetaKeys?: unknown; explain?: unknown }
        if (
          declared.localeSpecificMetaKeys !== undefined &&
          (!Array.isArray(declared.localeSpecificMetaKeys) ||
            declared.localeSpecificMetaKeys.some((key) => typeof key !== 'string' || key === ''))
        ) {
          invalid(`translations[${index}].allowance.localeSpecificMetaKeys は空でない文字列の配列`)
        }
        if (declared.explain !== undefined && typeof declared.explain !== 'function') {
          invalid(`translations[${index}].allowance.explain は関数でなければならない`)
        }
      }
      return {
        locale: locale as string,
        translatedFrom: translatedFrom as string,
        contentDir: contentDir as string,
        ...(notesDir === undefined ? {} : { notesDir: notesDir as string }),
        ...(allowance === undefined ? {} : { allowance: allowance as LocalizationAllowance }),
      }
    }),
  }
}

/** 設定無しは既存プロジェクト互換の原文 ja だけとして扱う。 */
export const loadProjectLocalizationConfig = async (
  projectDir: string,
): Promise<ProjectLocalizationConfig> => {
  const path = join(projectDir, 'locales.config.ts')
  if (!existsSync(path)) return LEGACY_JAPANESE_LOCALIZATION
  const module: { default?: unknown } = await import(pathToFileURL(path).href)
  return parseConfig(module.default)
}

/** 設定した相対ディレクトリが project root から逃げないことを二重に確認する。 */
export const directoryFromProject = (projectDir: string, path: string): string => {
  const directory = join(projectDir, path)
  if (relative(projectDir, directory).split('/').includes('..')) {
    invalid(`${path} が project root の外を指している`)
  }
  return directory
}
