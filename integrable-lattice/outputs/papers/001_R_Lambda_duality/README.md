# Paper 001: ℝ/Λ 双対 — 整数スペクトル曲線の二素点と、Λ 側の決定可能性

企画からの昇格: `outputs/paper-plans/002_R_Lambda_duality.md`（承認日 2026-07-26）。

## 本文の所在（重要）

**論文本体の正本は Typst ではなく構造化テキストである。**

```
integrable-lattice/structured-latex/content/
├── 001_intro.ts              第 1 章 序論（位置づけ・梯子・四軸）
├── 002_setup.ts              第 2 章 設定（整数スペクトル曲線・周期点数・Massieu Φ）
├── 003_archimedean.ts        第 3 章 アルキメデス側（既知。ここだけが ℝ を使う）
├── 004_lambda_finite.ts      第 4 章 Λ 側の有限・決定可能な命題群（A・B・C・N・L）
├── 005_duality.ts            第 5 章 中核命題 D と、その限界 3 点
├── 006_propositions_TVW.ts   第 6 章 命題 T・V・W
└── 007_asymmetry_scope.ts    第 7 章 決定可能性の非対称 / 第 8 章 スコープと形式検証
```

`000_scaffold.ts` は基盤の動作確認用の足場であり、論文本体ではない。

リポジトリ直下の `CLAUDE.md` が定めるとおり、**証明の正本は構造化テキスト**であり、
Typst で新規に証明を書かない。旧 Typst 一式は `integrable-lattice/_old/typst/` へ退避済み。

## 検証

```bash
# 構造化テキストの検証（型検査・実行時検証・負テスト）
cd integrable-lattice/structured-latex && npm run check

# 検証計算と論文の主張の対応
cd integrable-lattice && node sagemath/tools/verify-check-linkage.ts

# Lean（形式検証）
cd integrable-lattice/lean && lake build && bash scripts/check-no-sorry.sh
```

構造化テキストの検証には**本プロジェクト固有の検査**が含まれる。

- 本文ブロックは扱う量の**住処**（`habitat`）を宣言しなければならない
- 住処が非可算側（`R` / `C` / `mixed`）なら **`realEscape`（どこで ℝ へ脱出したか）が必須**、
  可算側なら `realEscape` は**書けない**（型で拒否される）
- 可算な住処を宣言したブロックの数式に ℝ/ℂ が現れたら実行時検証が落ちる

これは「可算と非可算を分別し、ℝ へ脱出した箇所を必ず明示する」という本プロジェクトの方針を
**型と実行時の両方で強制**するものである。

## 構成

- `computations/` — 検証計算への参照（実体は `sagemath/check/` に置いたまま）と対応表
- `notes.md` — 投稿方針、未完了作業、未解決リスク
- `refs.bib` — 参考文献

## 本論文の性質（読む前に）

**本論文は既知数学の再框（reframe）であり、新しい定理を主張しない。** この位置づけは
本文の第 1 章冒頭（`paper_positioning`）と第 8 章（`paper_remark_scope`）で明示してある。
残る未解決点 3 つは中核命題 D の限界として本文に明記されている。
