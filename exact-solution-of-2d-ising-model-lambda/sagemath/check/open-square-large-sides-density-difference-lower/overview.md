# SageMath Check: 基準辺の平方以上の二つの辺の密度の差の一様な下からの評価（q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_large_sides_density_difference_lower_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$a=1$、$(L,M)\in\{2,3\}^2$ の四組 × 正の有理数 6 点、199 検査。11 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

$a\ge1$、$a<L$、$a<M$、$a^2\le L$、$a^2\le M$、$L,M\le3$（一辺 4 以上の配位和は 10 分を超えるため含めない）を満たす四組と、
$0<q\le1$ の 6 点について、証明の中身を段ごとに検査する:
入れ替えた上端（`claim_open_square_large_sides_density_difference_upper_le_one` を第一の辺 $M$・第二の辺 $L$ で読む）
$\Psi_M+(-\Psi_L)\le R$、$R:=U+(-D)+\frac2aC$、
準備（$-(\Psi_M+(-\Psi_L))=\Psi_L+(-\Psi_M)$ を、台の各素数で逆元の定義・加法の定義・逆元の定義・$\mathbb Q$ の四則
$-(u+(-v))=v+(-u)$・逆元の定義・加法の定義の六段で確かめる。素数の個数だけ検査数が増える）、
本体（`claim_rational_log_order_group_neg_reverses_order` による $-R\le-(\Psi_M+(-\Psi_L))$ と、
準備の結論で読み替えた主張 $-R\le\Psi_L+(-\Psi_M)$）。
$\le_{\Lambda_{\mathbb Q}}$ は分母の最小公倍数を共通分母にした決定手続きで計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-large-sides-density-difference-lower/check.sage
```
