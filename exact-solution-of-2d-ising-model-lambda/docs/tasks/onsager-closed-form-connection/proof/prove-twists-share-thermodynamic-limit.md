# 四つのねじれが同じ熱力学極限を持つことを証明する

## 概要

有理点 $q\in\mathbb Q_{(0,1)}$ での分配多項式の値 $Z_L(q)$ を、四つの符号付き偶部分グラフ多項式の値の絶対値の最大 $\max_{(a,b)}|Q^{a,b}_L(q)|$ で両側から定数倍の範囲に評価する。これにより自由エントロピー密度の極限は、どのスピン構造のモード積から取っても同じになる。ねじれ間の密度差を直接評価する必要はない。全て可算側（$\mathbb Q$、実閉部分体 $R$、$\Lambda$）で閉じる。

## 採用する形（2026-10-09 の研究管理の決定。辺長 1〜3・有理点 6 箇所で厳密計算により確認済み。証明ではない）

記号は本文と [有限体積の閉じた積公式を組み立てる](assemble-finite-volume-closed-product.md) のもの。$R$ と $\omega$ は `def_real_closed_subfield` で固定した実閉部分体と虚数単位、$<_R$ は `def_real_algebraic_strict_order`、$s$ は $s^2=2$ の固定元、$x_c=-1+s$ は `def_critical_point`。

1. **1 の冪根の逆元は共役である。** $\zeta\in\mu_n$（`def_root_of_unity_set`）を $\zeta=\alpha+\beta\omega$（$\alpha,\beta\in R$。`def_real_closed_subfield` の一意表示）と書くと $\zeta^{-1}=\alpha-\beta\omega$、すなわち $\alpha^2+\beta^2=1$。
   根拠の骨子: $\tau(\alpha+\beta\omega):=\alpha-\beta\omega$ は $\overline{\mathbb Q}$ の環自己同型で $R$ を固定する。$N(\zeta):=\zeta\,\tau(\zeta)=\alpha^2+\beta^2\in R$ は乗法的で、$N(\zeta)^n=N(\zeta^n)=1$。
   $N(\zeta)$ は二つの平方の和なので $R$ で $\ge_R0$（`claim_real_closed_sum_of_two_squares_is_square`）。順序体 $R$ で $N\ge_R0$ かつ $N^n=1$ なら $N=1$（$N>_R1$ なら $N^n>_R1$、$0\le_RN<_R1$ なら $N^n<_R1$）。
   帰結: $\varpi+\varpi^{-1}=2\alpha\in R$、$2-\varpi-\varpi^{-1}=(1-\alpha)^2+\beta^2$ は $R$ の二つの平方の和、したがってある $c\in R$ の平方であり $\ge_R0$。**$|\varpi|=1$ や $\cos$ を使わない。**
2. **正値性の分解。** $\overline{\mathbb Q}[x]$ の等式
   $$\Delta(x;\varpi,\varsigma)-(x^2+2x-1)^2=x(1-x^2)\Bigl((2-\varpi-\varpi^{-1})+(2-\varsigma-\varsigma^{-1})\Bigr).$$
   $q\in\mathbb Q_{(0,1)}$ では $q(1-q^2)>0$、右辺の括弧は 1 により $R$ の平方の和、よって $\Delta(q;\varpi,\varsigma)\ge_R(q^2+2q-1)^2$。
   $q^2+2q-1\ne0$（根は $-1\pm s$（`claim_self_dual_quadratic_roots`）で $s\notin\mathbb Q$（`claim_no_rational_square_two`））なので $\Delta(q;\varpi,\varsigma)>_R0$。
3. **有理点での四つの $Q^{a,b}_L$ の符号。** 軌道ごとの明示積（同上の指示書の 4）の各因子を $q$ で評価する。$|O|\ge2$ の因子 $\Delta_O(q)$・$\Delta_O(q)^2$ は 2 により $>_R0$。
   $|O|=1$ の因子は $1+q^2>0$、$1+2q-q^2>0$（$0<q<1$）、$1-2q-q^2=-(q^2+2q-1)$ で、最後の符号だけが $q$ による。したがって
   - $q^2+2q-1<0$（$0<q<x_c$。$\mathbb Q$ で判定できる）なら四つとも $Q^{a,b}_L(q)>0$。
   - $q^2+2q-1>0$（$x_c<q<1$）なら $Q^{0,0}_L(q)<0$、他の三つは $>0$。
   値 $Q^{a,b}_L(q)$ は有理数なので、$R$ での符号は $\mathbb Q$ での符号である（`claim_positive_rational_positive_in_real_closed`）。
4. **低温側 $0<q<x_c$ の両側評価。** $Z_L(q)=\frac12\sum_{(a,b)}Q^{a,b}_L(q)$ と 3 から、$\mathbb Q$ で
   $$\tfrac12\max_{(a,b)}Q^{a,b}_L(q)\ \le\ Z_L(q)\ \le\ 2\max_{(a,b)}Q^{a,b}_L(q).$$
5. **高温側 $x_c<q<1$ の両側評価（双対な点へ移す）。** $t:=\mathrm{KW}(q)\in\mathbb Q_{(0,1)}$（`claim_kw_dual_preserves_unit_interval`）は $t^2+2t-1=-2(q^2+2q-1)(1+q)^{-2}<0$ を満たす（$\mathbb Q$ の四則）ので $0<t<x_c$。
   - $2^{L^2}Z_L(q)=H_L(q)=(1+q)^{2L^2}\bigl(G^{0,0}_L(t)+G^{0,1}_L(t)+G^{1,0}_L(t)+G^{1,1}_L(t)\bigr)$（`claim_high_temperature_polynomial_identity`、`claim_high_temperature_sector_decomposition`、`claim_sector_value_duality`。本文の `claim_partition_value_dual_factorization` がこの形）。
   - 各 $G^{c,d}_L(t)\ge0$ なので $\sum_{(c,d)}G^{c,d}_L(t)\ge G^{0,0}_L(t)=\frac12Z_L(t)$（`claim_low_temperature_trivial_sector_expression`）。
   - $t<x_c$ での 4 から $Z_L(t)\ge\frac12\max_{(a,b)}Q^{a,b}_L(t)$。
   - 自己双対性（同上の指示書の 6）を $x:=q$ で読み、$Q^{a,b}_L(t)>0$ を使うと $Q^{a,b}_L(t)=2^{L^2}(1+q)^{-2L^2}\,|Q^{a,b}_L(q)|$。
   - 合わせて $Z_L(q)\ge\frac14\max_{(a,b)}|Q^{a,b}_L(q)|$。上からは $Z_L(q)=\frac12\sum Q^{a,b}_L(q)\le\frac12\sum|Q^{a,b}_L(q)|\le2\max_{(a,b)}|Q^{a,b}_L(q)|$。
6. **まとめ（$\Lambda$ の鎖）。** 任意の $L\ge1$、$q\in\mathbb Q_{(0,1)}$ について、$\Lambda$ の中で
   $$\log\max_{(a,b)}|Q^{a,b}_L(q)|-2\ell_2\ \le\ \Phi_L(q)\ \le\ \log\max_{(a,b)}|Q^{a,b}_L(q)|+\ell_2$$
   （`def_finite_free_entropy`、`def_rational_log`。両端は正の有理数の対数）。$L^2$ で割ると定数項は密度の極限で消える。
   「四つのねじれが同じ極限を持つ」は、この評価と、四つのモード格子の Riemann 和が同じ積分へ収束すること（[有限モード和から Onsager 積分へ脱出する](pass-from-mode-sums-to-integral.md)）で述べる。

## 背景・前提

- 有限体積の閉じた積公式（軌道ごとの明示積・自己双対性）と、本文の実閉部分体の順序（「零点の詰め寄り」の章）・双対な点どうしの自由エントロピー（「Fisher 零点と双対性」の章）に依存する。
- 「一つのねじれが支配する」という説明だけで済ませず、上の評価を示す。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

有理点での値の評価まで。実対数と積分表示は次タスクへ分ける。

## 記号の帰属と ℝ 脱出の見込み

- 1〜3 は $R\subset\overline{\mathbb Q}$ の順序、4〜5 は $\mathbb Q$ の順序、6 は $\Lambda$ に住む。**実数への脱出はない。**

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`
- `exact-solution-of-2d-ising-model-lambda/sagemath/check/<対象名>/`（節ごと）
- `exact-solution-of-2d-ising-model-lambda/lean/Ising2DLambda/`（節ごとに具体版と必要十分版）

## 完了条件

- [ ] 1 の冪根の逆元が共役であることと、分散因子の有理点での正値性が $R$ の順序で証明されている。
- [ ] 有理点での四つの $Q^{a,b}_L$ の符号が、軌道ごとの明示積から決まっている。
- [ ] $\frac14\max|Q^{a,b}_L(q)|\le Z_L(q)\le2\max|Q^{a,b}_L(q)|$ が全ての $q\in\mathbb Q_{(0,1)}$ について証明され、$\Lambda$ の鎖に書かれている。
- [ ] 実数脱出が無いことが各ブロックの住処で確かめられている。
- [ ] 本文・SageMath linkage・Lean・PDF の全検証が通る。
