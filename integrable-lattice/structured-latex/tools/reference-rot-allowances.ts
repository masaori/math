/**
 * **検査 R の免除**（実在しない参照のうち、正当なもの／いま直せないもの）。
 *
 * 型と、型ごとに何を機械検証するかは reference-rot-model.ts の `ReferenceGrounds` の doc にある。
 * ここは表だけを持つ。**根拠なしの免除は型で書けない。**
 *
 * **`outOfScope` の登録は現在 0 件である**（cycle 26 step 2 が 17 件すべてを直した）。
 * 同型は「黙らせるための型」ではなく、本当に腐っていて直すのが当該 step の担当範囲外であるものを
 * **直すべきものとして記録**する型である。直れば「宣言が余っている」で赤になるので、
 * 直したのに宣言が残る状態は作れない——**実際、cycle 25 が記録した 17 件は
 * cycle 26 step 2 が直した時点で登録を消さねばならなくなった。設計どおりに働いた。**
 * 件数は毎回出力する。
 */

import type { ReferenceAllowance } from "./reference-rot-model.ts";

export const REFERENCE_ALLOWANCES: readonly ReferenceAllowance[] = [
  // --- 本文（ロケール）: cycle 24 step 2 の腐りのうち、手作業の訂正が届かなかった残り ---
  {
    file: "structured-latex/locales/en/content/003a_reader_guide.ts",
    reference: "content/000_reader_guide.ts",
    reason: "「当初の指示はここへ置くことだった。そうしていない」という否定の文脈で名を挙げている。",
    grounds: { type: "illustration", marker: "当初の指示はこの内容を" },
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
    file: "structured-latex/locales/en/diff-rules.ts",
    reference: "ja-en-exceptions.ts",
    reason: "「は当初『ブロック id → 理由の文字列』だった」＝過去の状態の記述。",
    grounds: { type: "historical", marker: "は当初「ブロック id → 理由の文字列」だった" },
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

  // --- docs / README: 「当初こう置く設計だったが作っていない」という過去の記述 -------------
  //
  // cycle 26 step 2 が、これらを**現在形の参照から過去形の記述へ書き換えた**。
  // 参照そのものは文中に残る（何を作らなかったかを書くため）ので、`historical` で説明する。
  {
    file: "README.md",
    reference: "inputs/queries/",
    reason: "「当初 …に置く設計だったが、cycle 0 の再定義以降は作っていない」＝過去の設計の記述。",
    grounds: { type: "historical", marker: "に置く設計だったが、cycle 0 の再定義" },
  },
  {
    file: "docs/architecture.md",
    reference: "inputs/queries/",
    reason: "同上。",
    grounds: { type: "historical", marker: "に置く設計だったが、cycle 0 の再定義以降は作っていない" },
  },
  {
    file: "structured-latex/tools/formalization-coverage.ts",
    reference: "Mathlib/Analysis/Polynomial/MahlerMeasure.lean",
    reason:
      "mathlib のファイル。形式化できない理由を一次情報で示すために、実測で見つけたファイル名を挙げている" +
      "（このファイルは 1 変数 ℂ[X] の Mahler 測度で、多変数を扱っていない）。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/formalization-coverage.ts",
    reference: "Mathlib/NumberTheory/MahlerMeasure.lean",
    reason:
      "同上（こちらは 1 変数 ℤ[X]）。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/external-theorem-coverage.ts",
    reference: "Mathlib/RingTheory/Trace/Basic.lean",
    reason:
      "mathlib のファイル。可換環の上のトレース双対が無いことの根拠として、実在する " +
      "`Module.Basis.traceDual` の宣言行（553 行）が体を要求していることを直読した先である。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/external-theorem-coverage.ts",
    reference: "Mathlib/Dynamics/Newton.lean",
    reason:
      "mathlib のファイル。`Newton` の語で当たるのがニュートン法であって Newton 多面体ではないことを" +
      "示すために挙げている（同名で別物を拾わないための根拠）。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/external-theorem-coverage.ts",
    reference: "Mathlib/RingTheory/MvPolynomial/Symmetric/NewtonIdentities.lean",
    reason:
      "mathlib のファイル。Newton の公式が**在る**ことの根拠として実測で見つけた先であり、" +
      "この 1 件があるので自分で証明する側ではなく mathlib から引く側へ振り分けた。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/formalization-coverage.ts",
    reference: "Mathlib/RingTheory/Henselian.lean",
    reason:
      "mathlib のファイル。cycle 42 step 2 の実測で、`HenselianLocalRing` が" +
      "この 1 ファイルにしか現れず、インスタンスが 1 つも無いことの根拠として挙げている。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/scope-claim-support.ts",
    reference: "Mathlib/RingTheory/Henselian.lean",
    reason:
      "mathlib のファイル。上と同じ実測の根拠であり、命題 T の段 3 が要求しているのが" +
      "円分体の完備化そのものではなく Hensel 的な局所環であることの出所である。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/external-theorem-coverage.ts",
    reference: "Mathlib/RingTheory/PowerSeries/Evaluation.lean",
    reason:
      "mathlib のファイル。cycle 43 step 4 の実測で、冪級数の評価写像が**在る**こと" +
      "（`PowerSeries.eval₂Hom`）と、それが要求している収束が線形位相での位相的冪零性であって" +
      "アルキメデス的でないことの根拠として挙げている。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/external-theorem-coverage.ts",
    reference: "Mathlib/RingTheory/PowerSeries/WeierstrassPreparation.lean",
    reason:
      "mathlib のファイル。cycle 44 step 4 の実測で、distinguished 多項式が**在る**こと" +
      "（`Polynomial.IsDistinguishedAt`）と、その値の付値を述べる宣言が無いことの根拠として" +
      "宣言行を直読した先である。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/external-theorem-coverage.ts",
    reference: "Mathlib/RingTheory/Polynomial/Eisenstein/Distinguished.lean",
    reason:
      "mathlib のファイル。同上。このファイルに `Valuation` が 1 度も現れないことを直読で確かめた。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/formalization-coverage.ts",
    reference: "Mathlib/RingTheory/RootsOfUnity/Lemmas.lean",
    reason:
      "mathlib のファイル。cycle 44 step 2 の実測で、$\\prod_{k=1}^{L-1}(1-\\zeta^{k})=L$ が**在る**こと" +
      "（`IsPrimitiveRoot.prod_one_sub_pow_eq_order`）の根拠として宣言行を直読した先である。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/formalization-coverage.ts",
    reference: "Mathlib/RingTheory/AdjoinRoot.lean",
    reason:
      "mathlib のファイル。cycle 44 step 1 の実測で、成分への射影が**在る**こと" +
      "（`AdjoinRoot.algHomOfDvd`）の根拠として宣言行を直読した先である。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "structured-latex/tools/external-theorem-coverage.ts",
    reference: "Mathlib/LinearAlgebra/FreeModule/PID.lean",
    reason:
      "mathlib のファイル。Smith 標準形が在ることの根拠として宣言行を直読した先である" +
      "（`Submodule.smithNormalForm` ほか。整除の鎖はここにも無い）。",
    grounds: { type: "otherProject", project: "integrable-lattice/lean/.lake/packages/mathlib" },
  },
  {
    file: "docs/paper-001-migration-status.md",
    reference: "tools/verify-no-lost-proofs.ts",
    reason: "「Ising 側にある …」＝別プロジェクトのファイル。",
    grounds: { type: "otherProject", project: "exact-solution-of-2d-ising-model" },
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
];
