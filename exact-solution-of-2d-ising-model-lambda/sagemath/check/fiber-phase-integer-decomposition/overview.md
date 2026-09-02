# SageMath Check: ファイバー位相和の三つの符号付き数え上げへの分解

**対象ラベル**: `claim_fiber_phase_integer_decomposition`

一辺 $L=2$ の全ファイバーと四つのスピン構造について、位相反転部分を除いた位相和が、
接触の無い部分、回転差 $4$ の部分の二倍、残余の三つの正負符号の個数差に等しいことを検査する。

- 実行: `sage sagemath/check/fiber-phase-integer-decomposition/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 全 $609$ ファイバー×四スピン構造の $2{,}436$ 組で等式と整数性を検査した。

計算は整数と円分体 $\mathbb Q(\zeta_8)$ の厳密演算だけで行い、浮動小数点は使わない。
