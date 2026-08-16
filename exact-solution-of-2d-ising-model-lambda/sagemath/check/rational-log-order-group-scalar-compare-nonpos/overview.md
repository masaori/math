# SageMath Check: 非正の元の有理数倍は係数の大小で比較できる（向きが逆）

## 対象

**対象ラベル**: `claim_rational_log_order_group_scalar_compare_nonpos`

- 実行日: 2026-08-16
- 状態: PASS（64 ベクトルのうち $\nu\le_{\Lambda_{\mathbb Q}}0$ を満たす 27 本、係数の組 $r\le s$ 28 組、主張の検査 756 件、鎖の検査 756 件。13 秒）
- 帰属: `ZZ`/`QQ` と素因数分解による厳密計算。浮動小数点は使わない。

## 検査内容

素数 $2,3,5$ の各係数を $-1,0,\tfrac12,\tfrac23$ から選ぶ有限台の有理係数ベクトル $\nu\in\Lambda_{\mathbb Q}$（零写像を含む）のうち
`def_rational_log_order_group_order` の決定手続きで $\nu\le_{\Lambda_{\mathbb Q}}0$ となるものと、
有理数 $r,s\in\{-2,-\tfrac12,0,1,\tfrac32,\tfrac74,3\}$、$r\le s$ のすべての組について
$s\cdot\nu\le_{\Lambda_{\mathbb Q}}r\cdot\nu$ を検査する。
さらに同じ組で証明の鎖を段ごとに検査する:
$c:=s-r\ge0$、非負有理数倍の順序保存を $\lambda:=\nu$、$\mu:=0$ で読んだ $c\cdot\nu\le_{\Lambda_{\mathbb Q}}c\cdot0$、$c\cdot0=0$、$c\cdot\nu\le_{\Lambda_{\mathbb Q}}0$、
加法単調性を $\lambda:=c\cdot\nu$、$\mu:=0$、$\nu:=r\cdot\nu$ で読んだ $c\cdot\nu+r\cdot\nu\le_{\Lambda_{\mathbb Q}}0+r\cdot\nu$、
鎖の等号 $s\cdot\nu=(c+r)\cdot\nu$（$c+r=s$）、$(c+r)\cdot\nu=c\cdot\nu+r\cdot\nu$、$0+r\cdot\nu=r\cdot\nu$。
$\le_{\Lambda_{\mathbb Q}}$ は分母の積を共通分母にした決定手続き、$\le_\Lambda$ は $\operatorname{rat}_\Lambda$ の値（正の有理数）の比較で計算する。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/rational-log-order-group-scalar-compare-nonpos/check.sage
```
