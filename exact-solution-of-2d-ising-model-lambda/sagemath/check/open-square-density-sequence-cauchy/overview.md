# SageMath Check: 開境界正方形の密度の列は Cauchy 列である（q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_density_sequence_cauchy_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$q\in\{1,\tfrac12,\tfrac23\}$、$\varepsilon$ は各 $q$ で倍率 $n=1$（$a=3$、$N=9$）になる元、$L,M\in\{9,10\}$。105 検査、35 秒）
- 帰属: `ZZ`/`QQ` による厳密計算。浮動小数点は使わない。

## 検査内容

証明の中身を段ごとに検査する:
準備の第一（$0\le\Gamma(q)$、Archimedes 性の倍率 $n$（$\Gamma(q)\le n\cdot\varepsilon$ となる最小の $n$）、$a:=n+2$、$N:=a^2$、$a\ge1$、$n\le a$、$a<a^2$、$N\ge1$）、
準備の第二（$N\le L,M$ から $a<L$、$a<M$、$a^2\le L$、$a^2\le M$）、
準備の第三（$\frac1a\Gamma(q)\le\varepsilon$。`claim_rational_log_order_group_div_ge_multiplier_le`）、
上端（$\Psi_L+(-\Psi_M)\le R_a$、$R_a=\frac1a\Gamma(q)$、結論 $\le\varepsilon$）、
下端（$-\varepsilon\le-\frac1a\Gamma(q)=-R_a\le\Psi_L+(-\Psi_M)$、結論）。

大きさについての注意。核 $\Gamma(q)$ は正なので倍率 $n\ge1$、$a\ge3$、$N\ge9$ であり、一辺 9 以上の開境界正方形の
分配関数の値 $Z^{\mathrm{op}}_{L,L}(q)\in\mathbb Q$ が要る。配位の全列挙（$2^{81}$ 通り）はできないので、
同じ和を行ごとに並べ替えた動的計画法（行配位 $2^L$ 通り。行内・隣接行間の破れボンド数で $q$ の冪を掛けて足す）で
計算し、一辺 2, 3 で配位の全列挙と一致することを確かめる。また $Z^{\mathrm{op}}_{L,L}(q)$（数十桁の整数の比）の
素因数分解は時間内に終わらないので、$\Lambda_{\mathbb Q}$ の元は素数ごとの辞書ではなく「正の有理数の対数の
有理数係数の形式和」（底 → 係数）で持ち、$\le_{\Lambda_{\mathbb Q}}$ は係数の分母の最小公倍数を掛けて $\Lambda$ の証人へ戻し、
$\mathrm{rat}_\Lambda$（正の有理数の積）の大小で比べる（`def_rational_log_order_group_order` の手続き。
$\mathrm{rat}_\Lambda$ が対数の和を積へ移すことは本文の主張）。定数 $\Gamma(q)$ については素数ごとの辞書とも一致を見る。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-density-sequence-cauchy/check.sage
```

## 実行結果

```text
rows == bruteforce for L=2,3: OK
q=1: n=1, a=3, N=9, checks=35
q=1/2: n=1, a=3, N=9, checks=35
q=2/3: n=1, a=3, N=9, checks=35
ALL PASS: 105 checks, 34.7s
```
