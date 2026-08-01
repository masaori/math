/**
 * ロケール集約の組み立て（検証ツールと検出テストが共有する）。
 *
 * 比較の実装はここには無い。**システム（リポジトリ直下 `structured-latex/`）の
 * `validateLocalizedRevision` / `resolveLocalized` が持つ**。ここがやるのは、
 * `content/` と 各ロケールの content を読んで 1 つの `LocalizedRevisionSnapshot` に束ね、
 * `locales.config.ts` が宣言した allowance を locale ごとに渡すことだけである。
 */

import {
  DEFAULT_NUMBERING_POLICY,
  resolveLocalized,
  validateLocalizedRevision,
  type LocalizationAllowances,
  type LocalizedRevisionSnapshot,
} from "../../../structured-latex/domain-model/index.ts";
import {
  loadContentFilesForLocale,
  loadNoteFiles,
  localizationConfig,
  sourceLocale,
} from "./content-modules.ts";

export const DOCUMENT_ID = "integrable-lattice/paper-001";

export const allowancesFromConfig = (): LocalizationAllowances =>
  Object.fromEntries(
    localizationConfig.translations
      .filter((translation) => translation.allowance !== undefined)
      .map((translation) => [translation.locale, translation.allowance!]),
  );

/** 全ロケールを読んでロケール集約を作る。 */
export const buildSnapshot = async (): Promise<LocalizedRevisionSnapshot> => {
  const notes = await loadNoteFiles();
  const localizations = [];
  for (const locale of [sourceLocale, ...localizationConfig.translations.map((t) => t.locale)]) {
    const isSource = locale === sourceLocale;
    const files = await loadContentFilesForLocale(locale);
    localizations.push({
      locale,
      translatedFrom: isSource
        ? null
        : (localizationConfig.translations.find((t) => t.locale === locale)?.translatedFrom ?? null),
      translatedFromRevision: isSource ? null : 1,
      revision: {
        documentId: DOCUMENT_ID,
        revision: 1,
        segments: files.map(({ file, blocks }) => ({
          key: file,
          blocks,
          notes: isSource ? (notes.find((entry) => entry.file === file)?.notes ?? []) : [],
        })),
      },
    });
  }
  return { documentId: DOCUMENT_ID, sourceLocale, localizations } as LocalizedRevisionSnapshot;
};

export type LocalizationCheck = {
  ok: boolean;
  /** 集約の不変条件違反（構造ドリフト・理由の無い翻訳限定ブロックなど）。 */
  issues: readonly unknown[];
};

/** 集約の不変条件だけを見る（採番・参照解決は `checkResolvable` が見る）。 */
export const checkStructure = (
  snapshot: LocalizedRevisionSnapshot,
  allowances: LocalizationAllowances,
): LocalizationCheck => {
  const result = validateLocalizedRevision(snapshot, allowances);
  if (result.success) return { ok: true, issues: [] };
  const error = result.error;
  return { ok: false, issues: "issues" in error ? error.issues : [error] };
};

/** 各ロケールが実際に解決できること（未解決参照が無いこと）。 */
export const checkResolvable = (
  snapshot: LocalizedRevisionSnapshot,
  allowances: LocalizationAllowances,
): LocalizationCheck => {
  const issues: unknown[] = [];
  for (const localization of snapshot.localizations) {
    const resolved = resolveLocalized(
      snapshot,
      localization.locale,
      { numbering: DEFAULT_NUMBERING_POLICY, audience: "publication" },
      allowances,
    );
    if (!resolved.success) issues.push({ locale: localization.locale, error: resolved.error });
  }
  return { ok: issues.length === 0, issues };
};
