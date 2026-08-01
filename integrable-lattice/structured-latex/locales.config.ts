/**
 * この文書が持つロケールの宣言。
 *
 * 原文は日本語（`content/` と `notes/`）である。英語版は**別プロジェクトではなく**、
 * 同じ文書の別の表層として `locales/en/content/` に置く。cycle 24 step 2 までは
 * `integrable-lattice/structured-latex-en/` が独立プロジェクトとして schema・生成物・
 * ツールを複製していた。その二重管理をやめ、ラベル型・スキーマ・生成器・検査を
 * 原文と共有する形へ移した。
 *
 * 原文と食い違ってよい箇所は `locales/en/allowance.ts` が**理由つきで**宣言する。
 * 宣言していない差は、システム（リポジトリ直下 `structured-latex/`）の構造照合が違反にする。
 */

import { englishAllowance } from "./locales/en/allowance.ts";

export default {
  sourceLocale: "ja",
  translations: [
    {
      locale: "en",
      translatedFrom: "ja",
      contentDir: "locales/en/content",
      allowance: englishAllowance,
    },
  ],
};
