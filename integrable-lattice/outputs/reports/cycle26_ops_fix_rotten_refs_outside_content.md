# cycle 26 step 2: 本文外に残っていた「本当に腐っている」参照 17 件を直し、免除を消した

変更: `structured-latex/locales/en/{allowance,diff-rules,frontmatter}.ts` /
`README.md` / `docs/{architecture,schemas,paper001-en-glossary}.md` /
`docs/tasks/auto-loop-runbook.md` / `structured-latex/tools/{reference-rot-allowances,verify-guards-detection-test}.ts`。

## 前提の実測

cycle 25 step 2 が作った検査 R は、実在しない参照 41 件のうち **17 件**を
**「本当に腐っている（実在しないものを現在形で指している）。直すのは当該 step の担当範囲外」**
として `outOfScope` 型で記録していた。着手時に実測して 17 件・内訳とも一致することを確認した。

| 場所 | 件数 |
|---|---|
| `structured-latex/locales/en/`（設定・宣言ファイル） | 5 |
| `docs/architecture.md` | 4 |
| `docs/paper001-en-glossary.md` | 3 |
| `docs/tasks/auto-loop-runbook.md` | 3 |
| `README.md` | 1 |
| `docs/schemas.md` | 1 |

**本文（`content/`）には 1 件も無い**（cycle 25 step 4b が本文側 12 件を直したため）。

## 結果

| 量 | 着手時 | 完了時 |
|---|---|---|
| 実在しない参照 | 41 件 | **24 件** |
| 免除 | 40 件 | **25 件** |
| **「本当に腐っている」（`outOfScope`）** | **17 件** | **0 件** |
| 説明のつかない腐り | 0 件 | 0 件 |

## 何をどう直したか

### 改名・移設で腐った参照（11 件）— 現在の実ファイルへ向け直した

| ファイル | 腐った参照 | 直した先 |
|---|---|---|
| `locales/en/allowance.ts` | `locales/en/math-exceptions.ts` | `locales/en/structure-exceptions.ts` |
| `locales/en/diff-rules.ts` | `verify-ja-en-detection-test.ts` | `tools/verify-localization-detection-test.ts` |
| `locales/en/frontmatter.ts` | `tools/verify-ja-en-correspondence.ts` | `tools/verify-localization.ts` |
| `locales/en/frontmatter.ts` | `../structured-latex/content/001_intro.ts` | `../../content/001_intro.ts` |
| `locales/en/frontmatter.ts` | `../outputs/reports/…venue_survey.md` | `../../../outputs/reports/…venue_survey.md` |
| `docs/paper001-en-glossary.md` | `content/008_prior_art.ts` | `structured-latex/locales/en/content/010_prior_art.ts` |
| `docs/paper001-en-glossary.md` | `content/001a_reader_guide.ts` ×2 | `structured-latex/locales/en/content/001a_reader_guide.ts` |
| `docs/paper001-en-glossary.md` | `ja-en-exceptions.ts` | `structured-latex/locales/en/structure-exceptions.ts` |
| `docs/tasks/auto-loop-runbook.md` | `schema.mjs` / `tools/validate-content.mjs` | `schema.ts` / `tools/validate-content.ts` |
| `docs/tasks/auto-loop-runbook.md` | `verify-no-lost-proofs.mjs` | `verify-no-lost-proofs.ts` |

**`locales/en/allowance.ts` の 1 件は監査のエラーメッセージの中にあった**——
違反時に「`locales/en/math-exceptions.ts` から消すこと」と実在しないファイル名を案内していた。
**読んだ人が探して見つからない**種類の腐りである。

**ついでに runbook の `content/*.mjs` / `notes/*.mjs` も `.ts` へ直した**
（検査 R は glob を含む記述を検出しないので挙がっていなかったが、
runbook 自身が「ソース形式は TypeScript に統一する（`.mjs` は使わない）」と書いている）。

### 作られなかった設計上のファイル（6 件）— 過去形の記述へ書き換えた

`inputs/queries/`・`inputs/seeds/{operations,axes,canonical-papers}.md` は
**cycle 0 の再定義（Λ-statement プログラム）より前の設計で挙げられ、一度も作られていない**。
実測: `inputs/seeds/` に現存するのは `lambda-statement-program.md` と `models.md` の 2 つだけである。

作る予定が無いので、**現在形の参照をやめ、「当初こう置く設計だったが cycle 0 の再定義以降は
作っていない」という過去形の記述へ書き換えた**。参照そのものは文中に残る
（**何を作らなかったかは記録として残すべきである**）ので、
検査には `historical` 型（過去の状態の記述。目印が同じファイルにあることを機械検証する）で説明する。

**これは「黙らせた」のではない。** `outOfScope`（＝直すべきものとして記録）から
`historical`（＝過去の記述として正しい）へ、**判定そのものを変えた**。
根拠は「作る予定が無いことが一次情報から確かめられる」ことである。

## 設計どおりに働いた 2 つの仕掛け

1. **`outOfScope` は「直れば宣言が余って赤くなる」型として作られていた。**
   実際、17 件を直した時点で登録を消さねばならなくなった。**設計どおりである。**
2. **検出テストが、生きた表を基準にしていたため落ちた。**
   `verify-guards-detection-test.ts` は `outOfScope` の免除を**生きた表から拾って**
   腐らせ方の基準にしていたので、表が空になった瞬間に例外で落ちた。
   **cycle 25 step 4b が `PROOF_DEBTS` で踏んだのと同じ形である。**
   同じ直し方（基準を固定値へ移す）で直した。**腐らせ方は 1 つも減らしていない**
   （検出テストは **24 / 24 件**のまま）。
   固定値は `historical` と同じ `(file, reference)` を借りている——
   借りないと「宣言が余っている」が先に出て、見たい腐り方に届かないためである。

## 限界（正直に書く）

- **検査 R は実在するかしか見ない。** 実在するが別のものを指している参照、
  拡張子を書かない言及、glob（`*` を含む記述）は検出しない。
  今回 `content/*.mjs` を直したのは検査が挙げたからではなく、**目視で気づいたからである**。
- 走査から外している場所（`outputs/reports/`・`MEMORY.md`・`auto-loop-state.md`・`_old/`・
  `sagemath/`・`lean/`・`inputs/`・`pipeline/`）は変わっていない。件数と理由は毎回出力される。
- **残る「実在しない参照」24 件はすべて説明済み**（例示・否定の文脈 6／過去の状態 14／生成物 4／
  別プロジェクト 1）で、**「本当に腐っている」は 0 件**である。

## 私が犯した誤り（隠さず記録する）

1. **免除を機械的に消すつもりで書いた正規表現が、40 件すべてを消した。**
   非貪欲の `(?:[^\n]*\n)*?` がオブジェクトの境界を越えて一致するのを確かめずに走らせた。
   検査が「説明のつかない腐り 24 件」で落ちて気づき、`git checkout` で戻してから
   行ベースの括弧対応で書き直した。**破壊的な一括置換を、少数で試さずに全体へ掛けた。**
2. **書き換えた `README.md` / `docs/architecture.md` が依然として `inputs/queries/` を含むことを、
   書き換える前に考えていなかった。** 過去形にしても文字列は残るので検査は挙げる。
   `historical` の登録が要ることに、検査が落ちてから気づいた。
3. **`grep` が `allowance.ts` の該当行を見つけられず、参照が既に直っていると誤って判断しかけた。**
   実際はファイルがバイナリ判定されていただけで、`/usr/bin/grep -a` では見つかった。
   **「見つからない」を「無い」と読みかけた。**
