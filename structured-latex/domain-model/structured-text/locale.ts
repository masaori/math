/**
 * L1（入力言語）: 文書を読ませる言語タグ。
 *
 * `Locale` は翻訳された文言の属性ではなく、同じ文書構造をどの言語で読ませるかを
 * 指すドメイン上の値である。値域は BCP 47 の言語タグとして実用上必要な部分集合に
 * 限る。すなわち、先頭に言語サブタグを置き、必要なら `-` 区切りで script / region /
 * variant 相当のサブタグを続ける。空文字列、空サブタグ、空白を含む値は受け入れない。
 *
 * TypeScript の `string` だけでは JSON 境界の値域を表せないので、境界では必ず
 * `localeRuntimeSchema` を通す。リテラル型を使う著者側の利便性を損なわないため、
 * 型そのものを branded string にはしない。
 */

import { z } from 'zod'

export type Locale = string

/**
 * BCP 47 のうち、このモデルが必要とする language[-subtag...] の形。
 *
 * private-use 専用タグ（`x-...`）や grandfathered tag は、翻訳の利用可能性を表す
 * この入口では受けない。これにより `ja--JP` や `english` のような曖昧な値を
 * JSON 境界で早期に拒否できる。
 */
export const BCP_47_LOCALE_PATTERN = /^[A-Za-z]{2,3}(?:-[A-Za-z0-9]{1,8})*$/

/**
 * BCP 47 は大文字小文字を区別しないため、同一性に使う値は canonical spelling に限定する。
 * `ja` と `JA`、`en-US` と `en-us` を別ロケールとして同居させないため、呼び出し側で
 * 正規化して保持するのではなく、境界で非正準表記を拒否する。
 */
export const canonicalLocaleOf = (locale: string): string | null => {
  try {
    return Intl.getCanonicalLocales(locale)[0] ?? null
  } catch {
    return null
  }
}

export const localeRuntimeSchema = z
  .string()
  .regex(BCP_47_LOCALE_PATTERN, 'locale は BCP 47 形式の language[-subtag...] でなければならない')
  .superRefine((locale, context) => {
    const canonical = canonicalLocaleOf(locale)
    if (canonical === null) {
      context.addIssue({ code: z.ZodIssueCode.custom, message: 'locale は有効な BCP 47 タグでなければならない' })
    } else if (canonical !== locale) {
      context.addIssue({
        code: z.ZodIssueCode.custom,
        message: `locale は正準表記 ${canonical} で指定しなければならない`,
      })
    }
  })
