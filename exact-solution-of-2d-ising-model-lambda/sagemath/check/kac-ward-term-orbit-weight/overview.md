# SageMath Check: 置換項の重みの軌道ごとの分解

**対象ラベル**: `claim_kac_ward_term_orbit_weight_factorization`

一辺二の周期正方格子の向き付き辺のうち先頭六本の全置換 $6!$ 個を取り、残りを固定した。
四つのスピン構造それぞれについて、置換項 $T^{a,b}_{\varphi}(x)$ を定義どおり
$\mathbb Q(\zeta_8)[x]$ で計算し、符号・固定辺の因子・軌道ごとの
$(-x)^{\lvert C\rvert}\prod\widehat M$ の積として独立に組んだ値と一致することを全数検査した。

- 実行: `sage sagemath/check/kac-ward-term-orbit-weight/check.sage`
- 状態: PASS（2026-08-30、$4\times6!=2{,}880$ 項）
- 浮動小数点: 不使用
