/**
 * **検査 R の免除**（実在しない参照のうち、正当なもの／いま直せないもの）。
 *
 * 型と、型ごとに何を機械検証するかは reference-rot-model.ts の `ReferenceGrounds` の doc にある。
 * ここは表だけを持つ。**根拠なしの免除は型で書けない。**
 *
 * **`outOfScope` は「黙らせるための型」ではない。** 本当に腐っていて、直すのが
 * cycle 25 step 2 の担当範囲外（本文・ロケール本文・docs・runbook）であるものを、
 * **直すべきものとして記録**する型である。直れば「宣言が余っている」で赤になるので、
 * 直したのに宣言が残る状態は作れない。件数は毎回出力する。
 */

import type { ReferenceAllowance } from "./reference-rot-model.ts";

/** `outOfScope` の記録先（本 step の report）。 */
const REPORT = "outputs/reports/cycle25_ops_guard_missing_proof_and_rotten_refs.md";
const RECORDED = { report: REPORT, marker: "## 5. 実在しない参照の実測と、その内訳" };

const outOfScope = (ownedBy: string): ReferenceAllowance["grounds"] => ({
  type: "outOfScope",
  ownedBy,
  recordedIn: RECORDED,
});

export const REFERENCE_ALLOWANCES: readonly ReferenceAllowance[] = [
  // --- 本文（ロケール）: cycle 24 step 2 の腐りのうち、手作業の訂正が届かなかった残り ---
  {
    file: "structured-latex/locales/en/content/005_duality.ts",
    reference: "../../docs/paper001-en-glossary.md",
    reason:
      "相対パスの深さが誤り（正しくは ../../../../docs/…）。cycle 24 step 2 の訂正が 12 ファイル中この 1 行だけ取り残した。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/005_duality.ts",
    reference: "tools/ja-en-exceptions.ts",
    reason: "撤去済みのツールを現在形で指している（現在は locales/en/structure-exceptions.ts）。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/005b_theta_infinity.ts",
    reference: "tools/ja-en-exceptions.ts",
    reason: "同上。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/007_asymmetry_scope.ts",
    reference: "tools/ja-en-exceptions.ts",
    reason: "同上。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/005c_ell2_family.ts",
    reference: "ja-en-exceptions.ts",
    reason: "同上（裸のファイル名）。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/009_s_infinity_decision.ts",
    reference: "ja-en-exceptions.ts",
    reason: "同上。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/009_theta_recursion.ts",
    reference: "ja-en-exceptions.ts",
    reason: "同上。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/001a_reader_guide.ts",
    reference: "../../outputs/reports/paper001_submission_venue_survey.md",
    reason: "相対パスの深さが誤り（正しくは ../../../../outputs/…）。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/001a_reader_guide.ts",
    reference: "content/000_reader_guide.ts",
    reason: "「当初の指示はここへ置くことだった。そうしていない」という否定の文脈で名を挙げている。",
    grounds: { type: "illustration", marker: "当初の指示はこの内容を" },
  },
  {
    file: "structured-latex/locales/en/content/001a_reader_guide.ts",
    reference: "009_prior_art.ts",
    reason: "実ファイルは 010_prior_art.ts（章番号の付け替えで書き換え漏れ）。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/010_prior_art.ts",
    reference: "../../outputs/reports/cycle18_T1_monsky1989_acquisition.md",
    reason: "相対パスの深さが誤り。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/010_prior_art.ts",
    reference: "../../outputs/reports/cycle17_T1_prior_art_check.md",
    reason: "相対パスの深さが誤り。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },
  {
    file: "structured-latex/locales/en/content/010_prior_art.ts",
    reference: "../../docs/tasks/auto-loop-state.md",
    reason: "相対パスの深さが誤り。",
    grounds: outOfScope("本文は cycle 25 step 4 の担当"),
  },

  // --- ロケールの設定・宣言ファイル（本 step の担当範囲外）---------------------------
  {
    file: "structured-latex/locales.config.ts",
    reference: "integrable-lattice/structured-latex-en/",
    reason: "「cycle 24 step 2 までは …が独立プロジェクトとして」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "cycle 24 step 2 までは" },
  },
  {
    file: "structured-latex/locales/en/README.md",
    reference: "integrable-lattice/structured-latex-en/",
    reason: "同上。",
    grounds: { type: "historical", marker: "cycle 24 step 2 までは" },
  },
  {
    file: "structured-latex/locales/en/README.md",
    reference: "build/en/document.tex",
    reason: "生成物（gitignore される）。",
    grounds: { type: "generated", producedBy: "build:tex:en" },
  },
  {
    file: "structured-latex/locales/en/README.md",
    reference: "build/en/refs.generated.bib",
    reason: "生成物（gitignore される）。",
    grounds: { type: "generated", producedBy: "build:tex:en" },
  },
  {
    file: "structured-latex/locales/en/allowance.ts",
    reference: "structured-latex-en/tools/verify-ja-en-correspondence.ts",
    reason: "「以前はこの役割を自前の …が持っていた」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "以前はこの役割を自前の" },
  },
  {
    file: "structured-latex/locales/en/allowance.ts",
    reference: "locales/en/math-exceptions.ts",
    reason:
      "監査のエラーメッセージが実在しないファイル名を指している（実ファイルは locales/en/structure-exceptions.ts）。読んだ人が探して見つからない。",
    grounds: outOfScope("locales/en/ は本 step の担当範囲外"),
  },
  {
    file: "structured-latex/locales/en/diff-rules.ts",
    reference: "ja-en-exceptions.ts",
    reason: "「は当初『ブロック id → 理由の文字列』だった」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "は当初「ブロック id → 理由の文字列」だった" },
  },
  {
    file: "structured-latex/locales/en/diff-rules.ts",
    reference: "verify-ja-en-detection-test.ts",
    reason: "改名済みのテストを現在形で指している（現在は tools/verify-localization-detection-test.ts）。",
    grounds: outOfScope("locales/en/ は本 step の担当範囲外"),
  },
  {
    file: "structured-latex/locales/en/frontmatter.ts",
    reference: "tools/verify-ja-en-correspondence.ts",
    reason: "撤去済みの比較器を現在形で指している（現在は tools/verify-localization.ts）。",
    grounds: outOfScope("locales/en/ は本 step の担当範囲外"),
  },
  {
    file: "structured-latex/locales/en/frontmatter.ts",
    reference: "../structured-latex/content/001_intro.ts",
    reason: "旧 structured-latex-en/ 時代の相対パスが残っている。",
    grounds: outOfScope("locales/en/ は本 step の担当範囲外"),
  },
  {
    file: "structured-latex/locales/en/frontmatter.ts",
    reference: "../outputs/reports/paper001_submission_venue_survey.md",
    reason: "旧 structured-latex-en/ 時代の相対パスが残っている。",
    grounds: outOfScope("locales/en/ は本 step の担当範囲外"),
  },
  {
    file: "structured-latex/locales/en/structure-exceptions.ts",
    reference: "verify-ja-en-correspondence.ts",
    reason: "「cycle 24 step 2 で比較器をシステム側へ移した（…を撤去）」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "cycle 24 step 2 で比較器をシステム側へ移した" },
  },

  // --- tools/（本 step の担当）: 過去の記述と生成物 ---------------------------------
  {
    file: "structured-latex/tools/build-latex.ts",
    reference: "structured-latex-en/tools/build-latex.ts",
    reason: "「それ以前は英語版が …として生成器ごと複製されており」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "として生成器ごと複製されており" },
  },
  {
    file: "structured-latex/tools/editions.ts",
    reference: "structured-latex-en/tools/build-latex.ts",
    reason: "「cycle 24 step 2 まで、英語版は …を持っていた」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "cycle 24 step 2 まで、英語版は" },
  },
  {
    file: "structured-latex/tools/editions.ts",
    reference: "structured-latex/build/",
    reason: "生成物の置き場（gitignore される）。",
    grounds: { type: "generated", producedBy: "build:tex" },
  },
  {
    file: "structured-latex/tools/validate-content.ts",
    reference: "structured-latex-en/tools/validate-content.ts",
    reason: "「それ以前は英語版が …として複製しており」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "未変換 Typst 記法の検査だけが" },
  },
  {
    file: "structured-latex/tools/verify-no-notes-in-output.ts",
    reference: "build/document.tex",
    reason: "生成物（gitignore される）。",
    grounds: { type: "generated", producedBy: "build:tex" },
  },
  {
    file: "structured-latex/tools/verify-no-notes-in-output.ts",
    reference: "structured-latex-en/tools/verify-no-notes-in-output.ts",
    reason: "「それ以前は英語版が …としてこの検査ごと複製されており」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "としてこの検査ごと複製されており" },
  },
  {
    file: "structured-latex/tools/verify-localization-detection-test.ts",
    reference: "verify-ja-en-detection-test.ts",
    reason: "「…の移植・拡張」＝撤去済みの旧テストを出所として挙げている（過去の状態）。",
    grounds: { type: "historical", marker: "免除の穴が塞がったことの実証" },
  },
  {
    file: "structured-latex/tools/reference-rot-model.ts",
    reference: "verify-ja-en-correspondence.ts",
    reason: "この検査が塞ぐ腐りそのものを例として引いている（撤去済みのツール名）。",
    grounds: { type: "illustration", marker: "cycle 24 step 2 で実際に起きたこと" },
  },
  {
    file: "structured-latex/tools/reference-rot-model.ts",
    reference: "verify:correspondence",
    reason: "同上（存在しなかった npm script 名を例として引いている）。",
    grounds: { type: "illustration", marker: "cycle 24 step 2 で実際に起きたこと" },
  },

  // --- 検出テストの再現データ（わざと腐らせた記述をソースに持っている）-----------------
  //
  // 検出テストは「腐っていた当時の記述」を再現データとして持つ。走査はその文字列も拾うので、
  // **免除しないと自分の再現データで赤くなる**。ファイルごと走査対象から外す手もあるが、
  // それは「このファイルなら何を書いてもよい」という穴になるので、1 件ずつ免除する。
  {
    file: "structured-latex/tools/verify-guards-detection-test.ts",
    reference: "tools/verify-ja-en-correspondence.ts",
    reason: "cycle 24 step 2 で腐っていた当時の記述を、検出できることの再現データとして持っている。",
    grounds: { type: "illustration", marker: "cycle 24 step 2 で腐っていた当時の記述" },
  },
  {
    file: "structured-latex/tools/verify-guards-detection-test.ts",
    reference: "verify:correspondence",
    reason: "同上（存在しなかった npm script 名の再現データ）。",
    grounds: { type: "illustration", marker: "cycle 24 step 2 で腐っていた当時の記述" },
  },
  {
    file: "structured-latex/tools/verify-guards-detection-test.ts",
    reference: "../../../content/001_intro.ts",
    reason:
      "**訂正後**の記述の再現データ。locales/en/content/ から見れば正しく解決するが、走査はこのソースファイル（tools/）からの相対で読むので解決しない。テストは正しい基準ファイルを渡して静かであることを確かめている。",
    grounds: { type: "illustration", marker: "訂正後の記述では挙がらない（偽陽性でない）" },
  },

  // --- docs / README（本 step の担当範囲外）-----------------------------------------
  {
    file: "README.md",
    reference: "inputs/queries/",
    reason: "構成として掲げているが未作成のディレクトリ。",
    grounds: outOfScope("README は本 step の担当範囲外"),
  },
  {
    file: "docs/architecture.md",
    reference: "inputs/queries/",
    reason: "同上。",
    grounds: outOfScope("docs は本 step の担当範囲外"),
  },
  {
    file: "docs/architecture.md",
    reference: "operations.md",
    reason: "inputs/seeds/ に置く予定として挙げているが未作成。",
    grounds: outOfScope("docs は本 step の担当範囲外"),
  },
  {
    file: "docs/architecture.md",
    reference: "axes.md",
    reason: "同上。",
    grounds: outOfScope("docs は本 step の担当範囲外"),
  },
  {
    file: "docs/architecture.md",
    reference: "canonical-papers.md",
    reason: "同上。",
    grounds: outOfScope("docs は本 step の担当範囲外"),
  },
  {
    file: "docs/schemas.md",
    reference: "inputs/seeds/operations.md",
    reason: "同上（スキーマの列挙元として名指ししているが未作成）。",
    grounds: outOfScope("docs は本 step の担当範囲外"),
  },
  {
    file: "docs/paper-001-migration-status.md",
    reference: "tools/verify-no-lost-proofs.ts",
    reason: "「Ising 側にある …」＝別プロジェクトのファイル。",
    grounds: { type: "otherProject", project: "exact-solution-of-2d-ising-model" },
  },
  {
    file: "docs/paper001-en-glossary.md",
    reference: "content/008_prior_art.ts",
    reason: "実ファイルは locales/en/content/010_prior_art.ts（移設と章番号の付け替えで腐った）。",
    grounds: outOfScope("docs は本 step の担当範囲外"),
  },
  {
    file: "docs/paper001-en-glossary.md",
    reference: "content/001a_reader_guide.ts",
    reason: "実ファイルは locales/en/content/001a_reader_guide.ts。",
    grounds: outOfScope("docs は本 step の担当範囲外"),
  },
  {
    file: "docs/paper001-en-glossary.md",
    reference: "ja-en-exceptions.ts",
    reason: "撤去済みのツールを現在形で指している。",
    grounds: outOfScope("docs は本 step の担当範囲外"),
  },
  {
    file: "docs/structured-latex-decision.md",
    reference: "tools/verify-shared-tools-in-sync.ts",
    reason: "冒頭が「以下は『なぜ一度は複製という判断をしたか』の記録として残す」と宣言している。",
    grounds: { type: "historical", marker: "「なぜ一度は複製という判断をしたか」の記録として残す" },
  },
  {
    file: "docs/structured-latex-decision.md",
    reference: "tools/generate-index.ts",
    reason: "同上（当時の複製表の行）。",
    grounds: { type: "historical", marker: "「なぜ一度は複製という判断をしたか」の記録として残す" },
  },
  {
    file: "docs/tasks/auto-loop-runbook.md",
    reference: "schema.mjs",
    reason:
      "実ファイルは schema.ts。runbook 自身が「ソース形式は TypeScript に統一する（.mjs は使わない）」と書いているのに、参照だけ .mjs のまま残っている。",
    grounds: outOfScope("runbook は本 step の担当範囲外"),
  },
  {
    file: "docs/tasks/auto-loop-runbook.md",
    reference: "tools/validate-content.mjs",
    reason: "同上（実ファイルは tools/validate-content.ts）。",
    grounds: outOfScope("runbook は本 step の担当範囲外"),
  },
  {
    file: "docs/tasks/auto-loop-runbook.md",
    reference: "verify-no-lost-proofs.mjs",
    reason: "同上（Ising 側の実ファイルは verify-no-lost-proofs.ts）。",
    grounds: outOfScope("runbook は本 step の担当範囲外"),
  },
];
