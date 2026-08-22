# Fourier 分解と分散因子を SageMath で厳密検算する

## 概要

ねじれた Fourier 共役とモード別小行列式の展開を円分体上の厳密計算で一行ずつ検算する。

## 背景・前提

- Fourier 因数分解と正方格子の分散因子の本文証明に依存する。
- `sagemath-checker` の規約に従う。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

有限代数計算だけを対象とし、極限や浮動小数点近似は行わない。

## 記号の帰属と ℝ 脱出の見込み

- `CyclotomicField(lcm(8,2L))` と有理函数体・Laurent 多項式環を使う。実数への脱出はない。

## 作業内容

### 共役と行列式の比較

- 四ねじれについて元行列と Fourier 共役後のブロック行列が一致することを検算する。
- 小行列式の直接計算と本文の分散因子を記号的に比較する。
- 各本文ラベル・検算ファイル・PASS 結果を `overview.md` に記録する。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/sagemath/check/kac-ward-fourier-dispersion/`

## 完了条件

- [ ] 四ねじれと複数の格子幅で厳密一致する。
- [ ] 一行一ファイル対応と対象ラベルの linkage がある。
- [ ] 浮動小数点を使っていない。
- [ ] 対象 SageMath、`verify-check-linkage.ts`、本文の全検証、PDF build が通る。
