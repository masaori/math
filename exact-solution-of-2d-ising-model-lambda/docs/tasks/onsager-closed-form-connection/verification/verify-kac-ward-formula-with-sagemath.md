# Kac--Ward 有限トーラス公式を SageMath で厳密検算する

## 概要

本文の Kac--Ward 公式を小さい周期格子で係数ごとに厳密検算し、四ねじれの符号・平方根分岐・正規化を固定する。

## 背景・前提

- 「四つの Kac--Ward 行列式による有限トーラス公式を証明する」に依存する。
- `sagemath-checker` と既存の `sagemath/check/` の一行一ファイル規約に従う。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

本文の各等式に対応する厳密検算だけを行い、新しい数学的主張を数値観察から追加しない。

## 記号の帰属と ℝ 脱出の見込み

- `CyclotomicField(8)` と多項式環で計算する。浮動小数点と数値平方根は使わない。
- 実数への脱出はない。

## 作業内容

### 係数比較

- 四行列を座標定義どおり生成し、行列式の形式平方根を定数項から再帰的に構成する。
- 全配位または全偶部分グラフから得た多項式と係数単位で比較する。
- 各本文ラベルと検算ファイルの対応、実行コマンド、PASS 結果を `overview.md` に記録する。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/sagemath/check/torus-kac-ward-formula/`

## 完了条件

- [ ] 少なくとも退化を避けられる複数の小格子で四ねじれ合成が直接数え上げと一致する。
- [ ] 各式変形が一行一検算ファイルへ対応し、対象ラベルが `overview.md` にある。
- [ ] 浮動小数点を使っていない。
- [ ] 対象 SageMath 実行と `verify-check-linkage.ts` が通る。
- [ ] 本文の `npm run check` と PDF build が通る。
