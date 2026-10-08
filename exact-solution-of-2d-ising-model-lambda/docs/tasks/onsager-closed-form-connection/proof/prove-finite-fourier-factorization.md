# ねじれた有限 Fourier 因数分解を証明する

## 概要

四つの Kac--Ward 多項式行列 $K^{a,b}(x)=I_{\vec E_L}-x\widehat{M^{a,b}}$（`def_kac_ward_polynomial_matrices`）を、トーラスの二方向の並進に対応するねじれた有限 Fourier 基底で同時にブロック対角化し、行列式 $D^{a,b}_L(x)$（`def_kac_ward_determinants`）をモードごとの $4\times4$ 小行列式の有限積へ分解する。$K^{a,b}(x)$ の定義だけに依存し、平方恒等式の完成を待たない。

## 採用する形（2026-10-08 の研究管理の決定）

研究管理（2026-10-08）が、下の 1〜6 を本文の定義どおりの $\mathbb Q(\zeta_{24})$ 上の厳密計算（分数で自前実装）で、辺長 $L=1,2,3$・四つのスピン構造の全てについて確かめた（固有ベクトル等式は $4L^2$ 本の Fourier ベクトルの全て、双対ベクトルとの内積は $(4L^2)^2$ 組の全て、積公式は $\prod\Delta=(Q^{a,b}_L)^2$ の形で、$Q^{a,b}_L$ は偶部分グラフの全列挙から独立に計算）。証明ではなく、計画が本文の定義のもとで一般の辺長で立つ形になっていることの確認である。記録は [研究管理の記録](../../research-management-log.md) の 2026-10-08 の回。

記号は本文のもの（頂点集合 $V_L=(\mathbb Z/L\mathbb Z)\times(\mathbb Z/L\mathbb Z)$ と代表元写像 $s$（`def_residue_maps`）、向き付き辺 $\vec E_L$、始点・終点 $\operatorname{src},\operatorname{tgt}$、反転 $\iota$、方向番号 $\operatorname{dir}$、直ちに引き返さない後続 $\operatorname{Next}$、回転位相 $\rho$、切断線偶奇 $c_{\mathrm h},c_{\mathrm v}$、ねじれ符号 $\varepsilon_{a,b}$、遷移行列 $M^{a,b}$、1 の冪根の全体 $\mu_n$（`def_root_of_unity_set`）、方向単位ベクトル $u:\mathbb Z/4\mathbb Z\to\mathbb Z\times\mathbb Z$（`def_direction_unit_vector`。$u(\pi_4(0))=(0,1)$、$u(\pi_4(1))=(1,0)$、$u(\pi_4(2))=(0,-1)$、$u(\pi_4(3))=(-1,0)$。第 1 成分が行の変位、第 2 成分が列の変位）を使う。**本文で $u$ は方向単位ベクトルの名前なので、モードの変数に $u,w$ を使わない。** 横方向（列）のモードを $\varpi$、縦方向（行）のモードを $\varsigma$ と書く（どちらも本文で未使用の文字。1 記号 1 意味）。

1. **モード集合。** $(a,b)\in\mathcal S$ に対し
   $$\mathcal U_a:=\{\varpi\in\overline{\mathbb Q}\mid \varpi^{L}=(-1)^{a}\},\qquad
   \mathcal W_b:=\{\varsigma\in\overline{\mathbb Q}\mid \varsigma^{L}=(-1)^{b}\}.$$
   $\mathcal U_0=\mathcal W_0=\mu_L$ であり $|\mu_L|=L$（`claim_root_of_unity_card`）。$a=1$ のときは、$|\mu_{2L}|=2L>L=|\mu_L|$ から $\xi\in\mu_{2L}\setminus\mu_L$ が取れ、$(\xi^L)^2=1$ かつ $\xi^L\ne1$ から $\xi^L=-1$（体 $\overline{\mathbb Q}$ で $1$ の平方根は $1,-1$ だけ）。すると $\mathcal U_1=\{\xi z\mid z\in\mu_L\}$（両包含）で $|\mathcal U_1|=L$。どの場合も $\mathcal U_a\subseteq\mu_{2L}$ であり、$\mathcal U_a$ の二つの元の比 $\varpi'/\varpi$ は $\mu_L$ に属する（$(\varpi'/\varpi)^L=(-1)^a/(-1)^a=1$）。$\mathcal W_b$ も同じ。
2. **モードの小行列。** 回転位相は方向番号だけで決まるので、$\delta,\delta'\in\mathbb Z/4\mathbb Z$ に対し $\rho_{\delta,\delta'}:=1,\zeta_8,\zeta_8^{-1}$（それぞれ $\delta'=\delta,\ \delta+1,\ \delta-1$）と書く（`def_rotation_phase` の三つの場合。$\delta'=\delta+2$ は後続にならない）。$(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b$ に対し、$\mathbb Z/4\mathbb Z$ を添字とする行列 $\widehat M(\varpi,\varsigma)\in\mathrm{Mat}_{\mathbb Z/4\mathbb Z}(\overline{\mathbb Q})$ を
   $$\widehat M(\varpi,\varsigma)_{\delta,\delta'}:=\begin{cases}
   \rho_{\delta,\delta'}\;\varpi^{\,u_2(\delta')}\,\varsigma^{\,u_1(\delta')},&\delta'\ne\delta+2,\\
   0,&\delta'=\delta+2
   \end{cases}$$
   で定める（$u(\delta')=(u_1(\delta'),u_2(\delta'))$。列の変位の冪が $\varpi$、行の変位の冪が $\varsigma$。冪は後続辺 $\delta'$ の方向で決まる）。行・列を $0,1,2,3$（右・下・左・上）の順に並べると
   $$\widehat M(\varpi,\varsigma)=\begin{pmatrix}
   \varpi & \zeta_8\varsigma & 0 & \zeta_8^{-1}\varsigma^{-1}\\
   \zeta_8^{-1}\varpi & \varsigma & \zeta_8\varpi^{-1} & 0\\
   0 & \zeta_8^{-1}\varsigma & \varpi^{-1} & \zeta_8\varsigma^{-1}\\
   \zeta_8\varpi & 0 & \zeta_8^{-1}\varpi^{-1} & \varsigma^{-1}
   \end{pmatrix}.$$
3. **ねじれ Fourier ベクトル。位置は終点で取る。** $(\varpi,\varsigma,\delta_0)\in\mathcal U_a\times\mathcal W_b\times\mathbb Z/4\mathbb Z$ に対し、$\vec E_L$ を添字とする列ベクトル $\psi^{\varpi,\varsigma,\delta_0}$ を
   $$\psi^{\varpi,\varsigma,\delta_0}(\vec e):=\begin{cases}
   \varpi^{\,s(j)}\,\varsigma^{\,s(i)},&\operatorname{dir}(\vec e)=\delta_0\ \text{かつ}\ \operatorname{tgt}(\vec e)=(i,j),\\
   0,&\operatorname{dir}(\vec e)\ne\delta_0
   \end{cases}$$
   で定める。**位置を始点でなく終点で取る理由**: 本文の $M^{a,b}_{\vec e,\vec f}=\varepsilon_{a,b}(\vec f)\rho(\vec e,\vec f)$ はねじれ符号を後続辺 $\vec f$ に付けている。$\vec f$ が切断線を横切る（$c_{\mathrm h}(\vec f)=1$ または $c_{\mathrm v}(\vec f)=1$）のは、$\operatorname{tgt}(\vec f)$ の代表座標が「$\operatorname{tgt}(\vec e)$ の代表座標に $u(\operatorname{dir}\vec f)$ を足したもの」から $L$ だけずれるときに限り、そのとき $\varpi^{\mp L}=(-1)^{a}$（または $\varsigma^{\mp L}=(-1)^{b}$）がねじれ符号 $\varepsilon_{a,b}(\vec f)$ と打ち消す（$(-1)^{2a}=1$）。位置を始点で取るとずれが起きるのは $\vec e$ が横切るときになり、$\vec f$ に付いた符号と対応しない。
4. **固有ベクトル等式（一つの論法: 成分ごとの場合分け）。** 任意の $\vec e\in\vec E_L$、$(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b$、$\delta_0\in\mathbb Z/4\mathbb Z$ について
   $$\bigl(M^{a,b}\psi^{\varpi,\varsigma,\delta_0}\bigr)(\vec e)=\widehat M(\varpi,\varsigma)_{\operatorname{dir}(\vec e),\,\delta_0}\;\psi^{\varpi,\varsigma,\operatorname{dir}(\vec e)}(\vec e).$$
   証明の骨子: $\operatorname{tgt}(\vec e)=(i,j)$ とする。$\vec f\in\operatorname{Next}(\vec e)$ で $\operatorname{dir}(\vec f)=\delta_0$ のものは、$\delta_0=\operatorname{dir}(\vec e)+2$ なら存在せず（その方向の辺は $\iota(\vec e)$ だけで、`def_nonbacktracking_successors` が除く）、そうでなければ「$(i,j)$ を始点とする方向 $\delta_0$ の向き付き辺」ただ一つである（`def_edge_numbering` の全単射性と `def_boundary_maps`。各頂点を始点とする各方向の向き付き辺はちょうど一本）。その $\vec f$ の終点は $(i,j)+_{V_L}\pi(u(\delta_0))$ で、代表座標は $s(i)+u_1(\delta_0)$、$s(j)+u_2(\delta_0)$ から、切断線を横切るときだけ $L$ だけ戻る。横切る・横切らないの場合分けで $\varepsilon_{a,b}(\vec f)\,\varpi^{s(j_{\vec f})}\varsigma^{s(i_{\vec f})}=\varpi^{s(j)+u_2(\delta_0)}\varsigma^{s(i)+u_1(\delta_0)}$ を示す（$\varpi^{L}=\varpi^{-L}=(-1)^{a}$ と $(-1)^{2a}=1$）。$L=1$ では横向きの辺はすべて切断線を横切り（$s(j)=0=L-1$）毎歩ずれるが、同じ式で扱える。**辺長で場合分けしない。**

   行列の言葉にするときは、$\mathcal M_{a,b}:=\mathcal U_a\times\mathcal W_b\times\mathbb Z/4\mathbb Z$（$|\mathcal M_{a,b}|=L\cdot L\cdot4=4L^2=|\vec E_L|$）との間の全単射 $\kappa:\vec E_L\to\mathcal M_{a,b}$ を一つ固定して書く（同一視しない。本文の行列は一つの有限集合を添字とする正方行列なので、$F\in\mathrm{Mat}_{\vec E_L}(\overline{\mathbb Q})$ を $F_{\vec e,\vec g}:=\psi^{\kappa(\vec g)}(\vec e)$ で定める）。すると $M^{a,b}F=FB$、ここで $B_{\vec g,\vec g'}:=\widehat M(\varpi,\varsigma)_{\delta,\delta'}$（$\kappa(\vec g)=(\varpi,\varsigma,\delta)$、$\kappa(\vec g')=(\varpi,\varsigma,\delta')$ がモードを共有するとき）、他は $0$。
5. **Fourier 行列の可逆性（両側を明示する）。** 双対ベクトル $\bar\psi^{\varpi,\varsigma,\delta_0}(\vec e):=\varpi^{-s(j)}\varsigma^{-s(i)}$（$\operatorname{dir}\vec e=\delta_0$、$\operatorname{tgt}\vec e=(i,j)$。他は $0$）を置き、$G:=L^{-2}\bar F$（$\bar F_{\vec g,\vec e}:=\bar\psi^{\kappa(\vec g)}(\vec e)$）とする。
   - $GF=I$: $\sum_{\vec e}\bar\psi^{\varpi,\varsigma,\delta}(\vec e)\psi^{\varpi',\varsigma',\delta'}(\vec e)$ は、$\delta\ne\delta'$ なら台が交わらず $0$。$\delta=\delta'$ なら、方向 $\delta$ の辺と終点との対応が全単射なので $\sum_{(i,j)\in V_L}(\varpi'/\varpi)^{s(j)}(\varsigma'/\varsigma)^{s(i)}=\bigl(\sum_{k=0}^{L-1}(\varpi'/\varpi)^{k}\bigr)\bigl(\sum_{k=0}^{L-1}(\varsigma'/\varsigma)^{k}\bigr)$。比は $\mu_L$ の元なので、$1$ でなければ幾何和は零（`claim_root_of_unity_geometric_sum_zero`）、$1$ なら $L$。よって対角で $L^2$、他で $0$。
   - $FG=I$: $(F\bar F)_{\vec e,\vec e'}=[\operatorname{dir}\vec e=\operatorname{dir}\vec e']\bigl(\sum_{\varpi\in\mathcal U_a}\varpi^{m}\bigr)\bigl(\sum_{\varsigma\in\mathcal W_b}\varsigma^{n}\bigr)$、$m=s(j)-s(j')$、$n=s(i)-s(i')$、$|m|,|n|\le L-1$。$a=0$ なら冪和 $S_{L,m}$（`claim_root_of_unity_power_sum_value`）で、$L\mid m$ すなわち $m=0$ のときだけ $L$、他は $0$。$a=1$ なら $\mathcal U_1=\xi\mu_L$ より $\sum(\xi z)^m=\xi^m S_{L,m}$ で同じ。負の $m$ は $\varpi^{m}=(\varpi^{-1})^{-m}$ と $\mu_L$ の逆元の閉性で正の冪へ戻す。
   正規化に $1/\sqrt L$ を使わず $1/L^2$ だけを使う。
6. **行列式の積公式。** 定数埋込み（`def_qbar_constant_embedding`）で $\widehat F,\widehat G,\widehat B$ を $\mathrm{Mat}_{\vec E_L}(\overline{\mathbb Q}[x])$ へ送ると $K^{a,b}(x)=I-x\widehat{M^{a,b}}=\widehat F\,(I-x\widehat B)\,\widehat G$。道具の章「有限集合上の多項式行列式の乗法性」で $\det_x K^{a,b}(x)=\det_x\widehat F\cdot\det_x(I-x\widehat B)\cdot\det_x\widehat G=\det_x(I-x\widehat B)$（$\det_x\widehat F\det_x\widehat G=\det_x(\widehat F\widehat G)=\det_x I=1$）。$I-x\widehat B$ は $\kappa$ による添字でモードごとのブロック対角行列なので、道具の章「ブロック対角行列の行列式は小行列式の積」（置換展開で、ブロックを保たない置換の項は零）により
   $$D^{a,b}_L(x)=\prod_{(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b}\det_x\bigl(I_4-x\,\widehat{\widehat M(\varpi,\varsigma)}\bigr)=\prod_{(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b}\Delta(x;\varpi,\varsigma).$$
   小行列式 $\Delta(x;\varpi,\varsigma)$ の計算は後続タスク [正方格子のモード別分散因子を計算する](compute-square-lattice-dispersion-factor.md)。

## 背景・前提

- Kac--Ward データの定義群、道具の章の「有限集合上の多項式行列式の乗法性」「ブロック対角行列の行列式は小行列式の積」、1 の冪根の道具（`def_root_of_unity_set`、`claim_root_of_unity_card`、`claim_root_of_unity_geometric_sum_zero`、`claim_root_of_unity_power_sum_value`）に依存する。
- `1` の冪根による有限 Fourier 行列を使い、解析的 Fourier 変換を持ち込まない。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

ブロック対角化と行列式の積への分解まで。小行列式の展開は後続タスクへ分ける。

## 記号の帰属と ℝ 脱出の見込み

- モードは $\mu_{2L}$ の元、Fourier 行列と小行列は $\mathbb Q(\zeta_8,\zeta_{2L})\subset\overline{\mathbb Q}$ に住み、行列式は $\overline{\mathbb Q}[x]$ に住む。
- 正規化に平方根 $1/\sqrt L$ を使わず、逆行列を $1/L^2$ と双対ベクトルで具体化する。実数への脱出はない。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`
- `exact-solution-of-2d-ising-model-lambda/sagemath/check/<対象名>/`（節ごと）
- `exact-solution-of-2d-ising-model-lambda/lean/Ising2DLambda/KacWard/`、`lean/Ising2DLambda/NecSuf/KacWard/`（節ごとに具体版と必要十分版）

## 完了条件

- [ ] 四ねじれすべてについてモード集合 $\mathcal U_a\times\mathcal W_b$ と小行列 $\widehat M(\varpi,\varsigma)$ が明示されている。
- [ ] 固有ベクトル等式・双対ベクトルとの内積（両側）・行列式の有限積分解が一ステップ一定理で証明されている。
- [ ] 実解析を使わず、全記号の住処が明示されている。添字集合の取り替えは全単射 $\kappa$ を明示して行い、同一視しない。
- [ ] 各節に SageMath（円分体上の厳密計算）と Lean 二版が付き、本文の全検証と PDF build が通る。
