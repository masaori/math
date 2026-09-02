# SageMath Check: 選択和の符号付き数え上げ表示

**対象ラベル**: `claim_selection_sum_signed_count`

一辺 $L=2$ で、互いに素な辺集合 $D,E$（$E$ は偶部分グラフ）の全ての組と四つのスピン構造
について、選択和 $\mathcal U^{a,b}_L(D,E)$ を定義の被加数の和として計算し、被加数の符号で
選択集合を二分した元の個数の差に一致することを検査する。

- 実行: `sage sagemath/check/selection-sum-signed-count/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 全 $881$ 組×四スピン構造の $3{,}524$ 件で等式と被加数の符号性を検査した。

計算は $\mathbb Z$ の厳密演算だけで行い、浮動小数点は使わない。
