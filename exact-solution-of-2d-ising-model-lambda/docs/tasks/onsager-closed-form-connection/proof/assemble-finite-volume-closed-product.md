# 有限体積の閉じた積公式を組み立てる

## 概要

分配多項式 $Z_L$ を、四つの符号付き偶部分グラフ多項式 $Q^{a,b}_L$（`def_signed_even_subgraph_polynomial`）の和として**低温変数 $x$ のまま**書き、平方恒等式（$Q^{a,b}_L$ は Kac--Ward 行列式の形式的平方根）と有限 Fourier 分解（行列式はモード積）を合わせて、$Z_L(x)$ を四つのモード積の平方根の和として明示する。各 $Q^{a,b}_L$ の $\overline{\mathbb Q}[x]$ での因数分解（軌道ごとの明示積）と、分散因子の自己双対性もここで扱う。

## 採用する形（2026-10-09 の研究管理の決定。辺長 1〜3 で厳密計算により確認済み。証明ではない）

記号は本文と [ねじれた有限 Fourier 因数分解を証明する](prove-finite-fourier-factorization.md)・[正方格子のモード別分散因子を計算する](compute-square-lattice-dispersion-factor.md) のもの（スピン構造 $\mathcal S$、モード集合 $\mathcal U_a\times\mathcal W_b$、分散因子 $\Delta(x;\varpi,\varsigma)=(1+x^2)^2-x(1-x^2)(\varpi+\varpi^{-1}+\varsigma+\varsigma^{-1})$、双対変換 $\mathrm{KW}(\xi)=(1-\xi)(1+\xi)^{-1}$（`def_kw_dual_transform`））。

1. **有限トーラス公式（低温変数のまま）。** $\mathbb Z[x]$ の等式
   $$Z_L=\frac12\sum_{(a,b)\in\mathcal S}Q^{a,b}_L .$$
   根拠は本文に既にある二つの主張だけである: $Z_L=2G^{0,0}_L$（`claim_low_temperature_trivial_sector_expression`）と
   $Q^{a,b}_L=\sum_{(c,d)}\chi_{a,b}(c,d)\,G^{c,d}_L$（`claim_signed_even_subgraph_sector_sum`。$\chi_{a,b}(c,d)=(-1)^{(1+a)c+(1+b)d+cd}$）。
   $(c,d)$ を固定して $(a,b)$ にわたり足すと $\sum_{(a,b)\in\mathcal S}\chi_{a,b}(c,d)=(-1)^{c+d+cd}\sum_{a}(-1)^{ac}\sum_{b}(-1)^{bd}=4\,[c=0]\,[d=0]$ なので
   $\sum_{(a,b)}Q^{a,b}_L=4G^{0,0}_L=2Z_L$ である（有限和の順序の交換。一つの論法）。
   **平方恒等式にも Fourier 分解にも依存しない。** Arf 符号 $\eta_{a,b}$（`claim_arf_fourier_sign_projection`）、高温展開の前因子 $2^{L^2}$、
   双対変数 $\mathrm{KW}(x)$ への置換は、$H_L$ を四つの平方根で書くときに要るものであり、$Z_L$ には要らない。四項の符号はすべて $+$ である。
2. **平方恒等式との合成。** 節 9 の $\operatorname{Pf}(\widehat K)=Q^{a,b}_L$ と $D^{a,b}_L=(Q^{a,b}_L)^2$、空集合の項から $Q^{a,b}_L(0)=1$、
   `claim_kac_ward_determinant_constant_term_one`、`claim_formal_square_root_exists`・`claim_formal_square_root_unique` により、
   $Q^{a,b}_L$ は $D^{a,b}_L$ の定数項 $1$ の形式的平方根 $\sqrt{D^{a,b}_L}\in\overline{\mathbb Q}[[x]]$ に一致する（多項式である）。
   したがって $Z_L=\frac12\sum_{(a,b)\in\mathcal S}\sqrt{D^{a,b}_L}$。
3. **Fourier 分解との合成。** $D^{a,b}_L=\prod_{(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b}\Delta(x;\varpi,\varsigma)$ を代入する。
4. **軌道ごとの明示積（$\overline{\mathbb Q}[x]$ での因数分解）。** $\Delta(x;\varpi,\varsigma)$ は $\varpi+\varpi^{-1}$ と $\varsigma+\varsigma^{-1}$ だけで決まるので、
   $\mathcal U_a\times\mathcal W_b$ 上で $(\varpi,\varsigma)\mapsto(\varpi^{-1},\varsigma)$ と $(\varpi,\varsigma)\mapsto(\varpi,\varsigma^{-1})$ が生成する位数 4 の群の各軌道 $O$ の上で
   $\Delta$ は一つの多項式 $\Delta_O$ に等しい。$|O|\in\{1,2,4\}$ であり、$|O|=1$ は $\varpi,\varsigma\in\{1,-1\}$ のときに限る。そのとき
   $$\Delta(x;1,1)=(1-2x-x^2)^2,\qquad \Delta(x;1,-1)=\Delta(x;-1,1)=(1+x^2)^2,\qquad \Delta(x;-1,-1)=(1+2x-x^2)^2 .$$
   よって $P^{a,b}_L:=\prod_{|O|=1}\sqrt{\Delta_O}\cdot\prod_{|O|=2}\Delta_O\cdot\prod_{|O|=4}\Delta_O^{\,2}$（$\sqrt{\Delta_O}$ は上の定数項 $1$ の多項式 $1-2x-x^2$, $1+x^2$, $1+2x-x^2$）は
   $\overline{\mathbb Q}[x]$ の多項式で、$(P^{a,b}_L)^2=\prod_{\mathcal U_a\times\mathcal W_b}\Delta=D^{a,b}_L$ かつ定数項 $1$。形式的平方根の一意性から $Q^{a,b}_L=P^{a,b}_L$。
   例: $Q^{0,0}_2=(1-2x-x^2)(1+2x-x^2)(1+x^2)^2$、$Q^{0,1}_2=\Delta(x;1,i)\,\Delta(x;-1,i)=1+14x^4+x^8$（$i^2=-1$）。
   この形が、有理点での各 $Q^{a,b}_L$ の符号を決める（[四つのねじれが同じ熱力学極限を持つことを証明する](prove-twists-share-thermodynamic-limit.md)）。
   $(0,1)$ で符号が変わりうる因子は $1-2x-x^2$ だけで、これはモード $(1,1)\in\mathcal U_0\times\mathcal W_0$ に由来し、$Q^{0,0}_L$ にだけ現れる。
5. **分散因子の自己双対性。** $\overline{\mathbb Q}(x)$ の等式
   $$(1+x)^4\,\Delta\bigl(\mathrm{KW}(x);\varpi,\varsigma\bigr)=4\,\Delta(x;\varpi,\varsigma).$$
   根拠: $1+\mathrm{KW}(x)^2=2(1+x^2)(1+x)^{-2}$、$1-\mathrm{KW}(x)^2=4x(1+x)^{-2}$、$\mathrm{KW}(x)(1-\mathrm{KW}(x)^2)=4x(1-x)(1+x)^{-3}$ を代入して整理する（$\mathbb Q(x)$ の四則）。
6. **符号付き偶部分グラフ多項式の自己双対性。** $\overline{\mathbb Q}[x]$ の等式
   $$(1+x)^{2L^2}\,Q^{a,b}_L\bigl(\mathrm{KW}(x)\bigr)=\eta_{a,b}\,2^{L^2}\,Q^{a,b}_L(x),\qquad \eta_{0,0}=-1,\ \ \eta_{a,b}=1\ ((a,b)\ne(0,0)).$$
   根拠: 左辺は多項式（$\deg Q^{a,b}_L\le2L^2$）で、5 と 3 から両辺の平方が等しい。整域では $f^2=g^2$ なら $f=\pm g$。符号は、
   $(a,b)\ne(0,0)$ では自己双対点 $x_{\mathrm{sd}}=-1+s$（$\mathrm{KW}(x_{\mathrm{sd}})=x_{\mathrm{sd}}$、$(1+x_{\mathrm{sd}})^2=2$）で $Q^{a,b}_L(x_{\mathrm{sd}})\ne0$（4 の因子はモード $(1,1)$ を含まないので全て零でない）から $+$、
   $(0,0)$ では $x=0$ での値 $Q^{a,b}_L(1)=\pm2^{L^2}$ と 1 の $\sum_{(a,b)}Q^{a,b}_L(1)=2Z_L(1)=2^{L^2+1}$ から $-$ が決まる。
   この等式は $x_c<q<1$ での分配多項式の下からの評価に使う（同上の指示書）。

## 背景・前提

- 1 は本文の既存の主張だけで閉じるので、台帳の順が来たらいつでも進められる。2〜4・6 は平方恒等式の節 9 と Fourier 分解の後に進める。5 は分散因子の計算の直後に進められる。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

有限体積の代数的恒等式だけを扱う。対数と極限は後続タスクへ分ける。

## 記号の帰属と ℝ 脱出の見込み

- 1・2 は $\mathbb Z[x]$、3・4・6 は $\overline{\mathbb Q}[x]$、5 は $\overline{\mathbb Q}(x)$ に住む。平方根は定数項 $1$ の形式的平方根（`def_sqrt_coefficient_recursion`）で固定する。実数への脱出はない。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`
- `exact-solution-of-2d-ising-model-lambda/sagemath/check/<対象名>/`（節ごと）
- `exact-solution-of-2d-ising-model-lambda/lean/Ising2DLambda/KacWard/`、`lean/Ising2DLambda/NecSuf/KacWard/`（節ごとに具体版と必要十分版）

## 完了条件

- [ ] $Z_L=\frac12\sum_{(a,b)}Q^{a,b}_L$ が $\mathbb Z[x]$ の等式として、既存のラベルだけを根拠に証明されている。
- [ ] 平方恒等式と Fourier 分解の後、$Q^{a,b}_L=\sqrt{D^{a,b}_L}$ と軌道ごとの明示積が証明され、$Z_L(x)$ の有限公式に未指定の符号・分岐が残っていない。
- [ ] 分散因子と $Q^{a,b}_L$ の自己双対性が $\overline{\mathbb Q}(x)$・$\overline{\mathbb Q}[x]$ の等式として証明されている。
- [ ] 各節に SageMath（厳密計算）と Lean 二版が付き、本文の全検証と PDF build が通る。
