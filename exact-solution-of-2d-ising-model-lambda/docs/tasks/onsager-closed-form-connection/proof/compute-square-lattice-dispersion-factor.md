# 正方格子のモード別分散因子を計算する

## 概要

Fourier 分解で得た向き成分の小行列式 $\Delta(x;\varpi,\varsigma):=\det_x\bigl(I_4-x\,\widehat{\widehat M(\varpi,\varsigma)}\bigr)$（$\widehat M(\varpi,\varsigma)$ は [ねじれた有限 Fourier 因数分解を証明する](prove-finite-fourier-factorization.md) の節 2）を置換展開で一行ずつ計算し、正方格子 Ising 模型の分散因子を $\varpi,\varsigma$ の Laurent 多項式として導く。

## 到達すべき式（2026-10-08 の研究管理が辺長 1〜3 で確認。証明ではない）

$$\Delta(x;\varpi,\varsigma)=(1+x^2)^2-x(1-x^2)\bigl(\varpi+\varpi^{-1}+\varsigma+\varsigma^{-1}\bigr).$$

- $\zeta_8$ は消える。左折・右折の位相 $\zeta_8^{\pm1}$ は、置換展開の各項で $\zeta_8\zeta_8^{-1}=1$ の対か、四つ巴の軌道の $\zeta_8^{\pm4}=-1$ の形でしか現れない（計算で確かめること。`def_rotation_phase` の約束 $\zeta_8^4=-1$ を引く）。
- $\varpi\leftrightarrow\varpi^{-1}$、$\varsigma\leftrightarrow\varsigma^{-1}$、$\varpi\leftrightarrow\varsigma$ の入れ替えで不変。
- 設計ノート `docs/discussion/対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md` との対応: 代数的略記 $\cos\theta_1:=(\varpi+\varpi^{-1})/2$、$\cos\theta_2:=(\varsigma+\varsigma^{-1})/2$、$\cosh2K:=(1+x^2)/(2x)$、$\sinh2K:=(1-x^2)/(2x)$（どれも解析関数ではなく $\mathbb Q(\varpi,\varsigma)(x)$ の元の名前）のもとで
  $$\Delta(x;\varpi,\varsigma)=4x^2\bigl[\cosh^2 2K-\sinh2K\,(\cos\theta_1+\cos\theta_2)\bigr].$$
  右辺の角括弧は Onsager の二重積分表示の被積分関数そのものである。ノートの一角の形 $\cosh\gamma(\theta)=\frac{(1+x^2)^2}{2x(1-x^2)}-\cos\theta$ は転送行列側の表示であり、ここでは使わない。
- 零点: $\varpi=\varsigma=1$ で $\Delta=(1+x^2)^2-4x(1-x^2)=(1-2x-x^2)^2$。零条件 $x^2+2x-1=0$ は自己双対方程式（`claim_kw_self_dual_quadratic_equivalence`、`def_critical_point`）。後続タスク [Onsager 閉形式を既存の極限と同定し臨界点へ接続する](identify-onsager-closed-form-and-critical-point.md) が使う。
- 辺長 1〜3 の確認: $\prod_{(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b}\Delta(x;\varpi,\varsigma)=(Q^{a,b}_L(x))^2$ が四つのスピン構造で成り立つ（$Q^{a,b}_L$ は `def_signed_even_subgraph_polynomial` のとおり偶部分グラフの全列挙から独立に計算）。例: $L=1$ では $\Delta(x;1,1)=(1-2x-x^2)^2$、$\Delta(x;-1,-1)=(1+2x-x^2)^2$、$\Delta(x;1,-1)=\Delta(x;-1,1)=(1+x^2)^2$。$L=2$ では $Q^{0,0}_2=1-4x^2-10x^4-4x^6+x^8$、$Q^{0,1}_2=Q^{1,0}_2=1+14x^4+x^8$、$Q^{1,1}_2=1+4x^2+6x^4+4x^6+x^8$。

## 背景・前提

- 「ねじれた有限 Fourier 因数分解を証明する」に依存する。
- 設計ノートの分散式は照合先であり、引用だけで済ませない。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

小行列式の代数計算と対称化まで。平方根の全体符号と有限積の合成は後続タスクへ分ける。

## 記号の帰属と ℝ 脱出の見込み

- `x` は不定元、モード変数 $\varpi,\varsigma$ は $\mu_{2L}$ の元として $\mathbb Q(\zeta_8,\zeta_{2L})[x]\subset\overline{\mathbb Q}[x]$ に住む。
- $\cos\theta$ は使わず $(\varpi+\varpi^{-1})/2$ という代数的略記から始める。実数への脱出はない。

## 作業内容

### 小行列式の展開

- 行列式を置換ごとの有限和（`def_qbar_polynomial_determinant`、$4!=24$ 項）へ展開し、零成分を含む項を落とし、同類項の統合を一行一操作で行う。
- $\varpi\varpi^{-1}=\varsigma\varsigma^{-1}=1$ と $\zeta_8^4=-1$ を使って反転不変な Laurent 多項式へ整理する。
- 後の実数脱出で使う分散量との代数的対応（上の $\cosh2K,\sinh2K,\cos\theta$ の略記）を定義するが、`arccosh` は導入しない。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`
- `exact-solution-of-2d-ising-model-lambda/sagemath/check/<対象名>/`
- `exact-solution-of-2d-ising-model-lambda/lean/Ising2DLambda/KacWard/`、`lean/Ising2DLambda/NecSuf/KacWard/`

## 完了条件

- [ ] 小行列式と分散因子の等式が省略なしで証明されている。
- [ ] 既存ノートの式との変数・前因子・正規化の対応が明示されている。
- [ ] SageMath（円分体上の厳密計算）と Lean 二版が付き、本文の全検証と PDF build が通る。
