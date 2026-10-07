# 四つの Kac--Ward 行列式による有限トーラス公式を証明する

## 概要

各スピン構造 $(a,b)\in\mathcal S$ について、Kac--Ward 行列式 $D^{a,b}_L(x)=\det_x K^{a,b}(x)$（`def_kac_ward_determinants`）が符号付き偶部分グラフ多項式の平方 $(Q^{a,b}_L(x))^2$（`def_signed_even_subgraph_polynomial`）に等しいことを、任意の $L\ge1$ について $\overline{\mathbb Q}[x]$ の等式として証明する。その後、既存の `claim_signed_even_subgraph_sector_sum`・`claim_arf_fourier_sign_projection`・高温展開の恒等式と合成して、分配多項式を四つの行列式の定数項一の平方根の符号付き和として書く。

## 採用する経路（2026-10-03 の研究管理の決定）

行列式の置換展開と偶部分グラフ対を鍵ごとに直接比較する旧経路は使わない（経過は [auto-loop-archive.md](../../auto-loop-archive.md) に保管）。代わりに次の経路を採る。出典は Chelkak, Cimasoni, Kassel, *Revisiting the combinatorics of the 2D Ising model*, Ann. Inst. Henri Poincaré D 4 (2017) 309–385, arXiv:1507.08242 の 1.3 節（$\mathrm K=\mathrm J\cdot\mathcal{KW}$、$\widehat{\mathrm K}=i\mathrm U^*\mathrm K\mathrm U$）、2.1 節（補題 2.1、2.2）、2.2 節（定理 1.1 の証明、主張 A）、4.2 節（定理 4.2: 曲面上の $\det\mathcal{KW}_\lambda=(\sum_P(-1)^{q_\lambda([P])}x(P))^2$）である。出典は「端末グラフ」と呼ぶ補助グラフを導入するが、本文では導入しない。添字集合は向き付き辺の集合 $\vec E_L$ のままで足り、「長い対」$\{\vec e,\iota(\vec e)\}$ と「短い対」$\{\vec e,\vec f\}$（$\operatorname{src}(\vec e)=\operatorname{src}(\vec f)$、$\vec e\ne\vec f$）という二種類の対だけを使う（不要な構造を持ち込まない）。ただし対の種類を二元集合の一致で区別しない。$L=1$ では長い対と短い対が同じ二元集合になるので、対の集合は長い対の集合と短い対の集合の**非交和**（標識付き）として定める（2026-10-05 の研究管理の決定。節 4）。

記号は本文のもの（$\vec E_L$、反転写像 $\iota$、方向番号 $\operatorname{dir}$ とその標準整数代表 $r_4$、回転位相 $\rho$、ねじれ符号 $\varepsilon_{a,b}$、遷移行列 $M^{a,b}$、多項式行列 $K^{a,b}(x)=I-x\widehat{M^{a,b}}$、巻き付き二次符号 $\chi_{a,b}(h,v)=(-1)^{q_{a,b}(h,v)}$、$q_{a,b}(h,v)=hv+(1-a)h+(1-b)v$）を使う。虚数単位は $\zeta_8^{\,2}$ と書く。

### 節の列（台帳のセクション表と同じ順。各節は一つの論法で閉じる大きさに割ってから着手する）

1. **反転置換行列と端末行列。** $J\in\mathrm{Mat}_{\vec E_L}(\mathbb Z)$ を $J_{\vec e,\vec f}:=1$（$\vec f=\iota(\vec e)$）、$0$（それ以外）で定める。$J^2=I$。$\det J=1$（$\iota$ は $2L^2$ 個の互換の積で、$(-1)^{2L^2}=1$。`claim_reversal_has_no_fixed_point`、符号の乗法性）。$J$ の整数成分を包含準同型 $\mathbb Z\hookrightarrow\overline{\mathbb Q}$ と定数多項式への写像で送った行列を $\widehat J$ とし、$K^{a,b}_{\mathrm t}(x):=\widehat J\,K^{a,b}(x)$ と定めると、$\det K^{a,b}_{\mathrm t}(x)=D^{a,b}_L(x)$ であり、成分は
   $$(K^{a,b}_{\mathrm t})_{\vec e,\vec f}
   =\begin{cases}1,&\vec f=\iota(\vec e),\\0,&\text{それ以外}\end{cases}
   -x\begin{cases}\widehat{\varepsilon_{a,b}(\vec f)\rho(\iota(\vec e),\vec f)},&
   \operatorname{src}(\vec f)=\operatorname{src}(\vec e),\ \vec f\ne\vec e,\\0,&\text{それ以外}\end{cases}$$
   である（$J$ を左から掛けると行 $\vec e$ が行 $\iota(\vec e)$ になることと、`def_kac_ward_transition_matrices`、`def_nonbacktracking_successors` による）。
   一辺一では二つの非零条件が重なるので、独立した二つの寄与の差として扱う（本文 `claim_terminal_matrix_entries` はそうなっている）。無ねじれの反転辺成分は $1-x$ である。後続の扱いは節 4 の標識付きマッチング展開で決めた（2026-10-05 の研究管理）。$\det K^{a,b}_{\mathrm t}(x)=D^{a,b}_L(x)$ が引く「行列式の乗法性」は本文に節が無かったので、道具の章の節「有限集合上の多項式行列式の乗法性」として閉じ、本文の根拠と Lean（`Matrix.det_mul` を自前の補題へ）を直す（台帳の行「端末行列の行列式の一致の根拠を本文のラベルへ直す」）。
2. **対角相似による反対称化。** 各 $\vec e$ のねじれ偶奇 $\kappa_{a,b}(\vec e)\in\{0,1\}$ を $\varepsilon_{a,b}(\vec e)=(-1)^{\kappa_{a,b}(\vec e)}$ で定め（切断線を横切る偶奇から直接定義する。向きに依らない）、
   $$U:=\operatorname{diag}\bigl(u_{\vec e}\bigr),\qquad u_{\vec e}:=\zeta_8^{\,-r_4(\operatorname{dir}(\vec e))}\,\zeta_8^{\,-2\kappa_{a,b}(\vec e)},\qquad \widehat K^{a,b}(x):=\zeta_8^{\,2}\,U^{-1}K^{a,b}_{\mathrm t}(x)\,U$$
   と置く。主張: (i) $\widehat K^{a,b}(x)$ は反対称で対角成分は零（長い対の成分は $\pm1$、短い対の成分は $\pm x\cdot(\text{8 乗根})$、場合分けは直進・左折・右折の三通りと長い対の二通り）。(ii) $\det\widehat K^{a,b}(x)=(\zeta_8^{\,2})^{4L^2}\det K^{a,b}_{\mathrm t}(x)=D^{a,b}_L(x)$。本文では $U^{-1}$ を明示的な両側逆行列 $V$ として構成し、$\widehat K:=C(\zeta_8^{\,2})\,(\widehat V K^{a,b}_{\mathrm t}(x)\widehat U)$ と定めてある（`def_gauged_terminal_matrix`）。(ii) は道具の章の「有限集合上の多項式行列式の乗法性」と「多項式行列式のスカラー倍」を引き、$\det\widehat V\det\widehat U=\det(\widehat V\widehat U)=1$ と $(\zeta_8^{\,2})^{4L^2}=1$ から示す（道具の節が先に閉じていなければ先に閉じる。2026-10-05 の研究管理）。研究管理が一辺二・三の全スピン構造で浮動小数点により (i)(ii) を確認した（証明ではない）。SageMath は円分体 $\mathbb Q(\zeta_8)$ 上で厳密に行う。
3. **有限集合上の Pfaffian と平方の定理。** 線形順序を持つ偶数個の元の有限集合（ここでは $\vec E_L$、$|\vec E_L|=4L^2$）の完全マッチング（二元集合への分割）を定義し、各マッチング $\mathcal D$ の符号 $\operatorname{sgn}(\mathcal D)$ を、対を $\{i_1<j_1\},\dots$ と並べたときの置換の符号で定める（並べ方に依らないことを示す）。反対称行列 $A$ の Pfaffian を $\operatorname{Pf}(A):=\sum_{\mathcal D}\operatorname{sgn}(\mathcal D)\prod_{\{i<j\}\in\mathcal D}A_{ij}$ で定め、$\operatorname{Pf}(A)^2=\det A$ を証明する。証明は、置換展開で不動点を持つ項が零であること、奇数長の軌道を持つ置換がその軌道の反転と対で相殺すること（反対称性で符号が奇数回変わる）、全ての軌道が偶数長の置換と順序付きマッチング対 $(\mathcal D_1,\mathcal D_2)$ の 1 対 1 対応（各軌道の最小元から $\mathcal D_1$ の対を先に辿る向きで定める）の三段で行う。本文の置換・軌道の道具（`claim_moved_orbit_partition` の周辺）を使う。一般の零対角反対称行列について述べ、成分の二項分解や標識は持ち込まない。Lean 具体版は自前で証明する。
4. **標識付きマッチング展開と、端末行列の完全マッチングと偶部分グラフ。** まず標識付き展開（一辺一の扱い。2026-10-05 の研究管理の決定）。$\widehat K_{\vec e,\vec f}=C(\ell_{\vec e,\vec f})-xC(q_{\vec e,\vec f})$ は長い対の寄与と短い対の寄与の差である（`claim_gauged_terminal_matrix_skew` の証明の形）。分配則により、$\operatorname{Pf}(\widehat K)$ は、完全マッチングの各対に「長い」「短い」の標識を付けた**標識付き完全マッチング** $\mathcal D$ にわたる和 $\sum_{\mathcal D}\operatorname{sgn}(\mathcal D)\prod(\text{標識の寄与})$ になる（対の個数についての帰納法。一つの論法なので台帳では別の行）。標識付きの対の集合は、長い対 $(e,\iota(e))$ の集合と短い対の集合の非交和として定める。零でない項は、長い標識の対が $(e,\iota(e))$ の形、短い標識の対が同じ始点を持つ相異なる二辺のものに限る。$L\ge2$ では標識は対から一意に決まり、$L=1$ では $\{\vec e,\iota(\vec e)\}$ に両方の標識が現れる。以後の $\mathcal D$ は標識付きのものとする。次に、写像 $\mathcal D\mapsto P(\mathcal D):=\{e\in E_L\mid (e,\iota(e))\text{ が長い標識で }\mathcal D\text{ に入らない}\}$ を定め、$P(\mathcal D)$ が偶部分グラフであること（各頂点で、長い標識に入らない出辺の個数は短い標識の対で二つずつ組まれるので偶数）、短い標識の対の個数が $|P(\mathcal D)|$ に等しく（対の総数 $2L^2=|E_L|$ から長い標識の対の個数を引く）項の $x$ の冪が $x^{|P(\mathcal D)|}$ であること、固定した偶部分グラフ $P$ の上の標識付きマッチングは各頂点の $P$ の半辺の局所対合の選び方と 1 対 1（次数 0・2 では一通り、次数 4 では三通り。$L=1$ では短い標識の対 $\{\vec e,\iota(\vec e)\}$ が、辺 $e$ の二つの半辺を互いに組む局所対合に当たる）であることを示す。
5. **基準マッチングとの対称差の閉路。** 基準マッチング $\mathcal D_0$（全ての長い標識の対 $(e,\iota(e))$、$e\in E_L$。Pfaffian の定数項を与える）と $\mathcal D$ の対称差 $\mathcal D\triangle\mathcal D_0$（標識込みで取る）は、長い標識と短い標識の対が交互に並ぶ、頂点（向き付き辺）を共有しない閉路の族になる。$L=1$ の短い標識の対 $\{\vec e,\iota(\vec e)\}$ は長さ一の閉歩道 $(\vec e)$（$\operatorname{tgt}(\vec e)=\operatorname{src}(\vec e)$ かつ $\vec e\ne\iota(\vec e)$ なので非後退）に当たり、台は $\{e\}$ である。各閉路を向き付き辺の列として読むと、閉じた非後退辺列で台の辺が相異なるもの（本文の「台の辺が相異なる閉歩道」）になり、その台の合併が $P(\mathcal D)$ である。長い対 $\{\vec e,\iota(\vec e)\}$ から短い対 $\{\iota(\vec e),\vec f\}$ へ進むとき、辺列の隣接二辺は $\vec e,\vec f$ で、短い対の成分は $-x\,\varepsilon_{a,b}(\vec f)\rho(\vec e,\vec f)$ である。
6. **閉歩道の位相と二次符号の一般形。** 台の辺が相異なる閉じた非後退辺列 $\gamma$ について
   $$-\Bigl(\prod_k\varepsilon_{a,b}(\vec e_k)\Bigr)\zeta_8^{\,t_\circ(\gamma)}=\chi_{a,b}\bigl(h(\gamma),v(\gamma)\bigr)\,(-1)^{t(\gamma)}$$
   （$t(\gamma)$ は横断数 `def_closed_walk_crossing_number` の周辺）を示す。頂点単純な場合は `claim_vertex_simple_orbit_quadratic_sign` で済んでいる。一般の場合は横断消去（`claim_smoothing_cyclic_turning_invariance`、切断線偶奇の保存、二本への分割、横断数の真の減少による整礎帰納）と接触点分割（`claim_contact_elimination_by_splitting` とその回転数差の等式）で頂点単純な閉路族へ落とし、巻き付き二次符号の加法性 $q(\alpha+\beta)=q(\alpha)+q(\beta)+\alpha\cdot\beta$（$\alpha\cdot\beta=h_\alpha v_\beta+h_\beta v_\alpha \bmod 2$）で合成する。**新しい補題が一つ要る**: 台の辺が相異なる二本の閉歩道の混合横断数の偶奇は、巻き付き偶奇の交差形式 $h_1v_2+h_2v_1 \bmod 2$ に等しい。閉路族全体では、横断数の総和（自己横断と混合横断）を $t(\mathcal D)$（$\mathcal D$ の短い対のうち交差する組の個数）と同定する。 **この節の Lean は、台帳のセクション表でこの節の直前に並べた離散 Whitney 系の Lean 配線（Kac--Ward 章の定義群、`lean:` の無い主張、周期単純路と頂点単純閉路の回転数、頂点単純軌道の二次符号）が閉じてから書く。節 1〜5 はこれらに依存しないので先に進める（2026-10-04 の研究管理の決定）。**
7. **マッチングの符号と基準マッチングの比較。** $\operatorname{sgn}(\mathcal D)\operatorname{sgn}(\mathcal D_0)\prod(\widehat K\ \text{の}\ \mathcal D\ \text{の成分})$ を、対称差の各閉路 $\gamma_j$ の寄与の積 $\prod_j\bigl(-x^{|\gamma_j|}\prod\varepsilon_{a,b}\,\rho\bigr)$ へ分解する。$\operatorname{sgn}(\mathcal D)\operatorname{sgn}(\mathcal D_0)$ は各閉路を一つずつ回す置換の符号の積、$U$ の成分と $\zeta_8^{\,2}$ の因子は閉路に沿って打ち消し合う（長い対と短い対が交互に並ぶため）。前節と合わせて
   $$\operatorname{sgn}(\mathcal D)\prod_{\{i<j\}\in\mathcal D}\widehat K_{ij}=\operatorname{sgn}(\mathcal D_0)\prod_{\{i<j\}\in\mathcal D_0}\widehat K_{ij}\cdot\chi_{a,b}\bigl(h(P),v(P)\bigr)\,(-1)^{t(\mathcal D)}\,x^{|P(\mathcal D)|}$$
   を得る（$h(P),v(P)$ は $P(\mathcal D)$ の巻き付き偶奇。閉路族の巻き付き偶奇の和に等しい）。 ここで $t(\mathcal D)$ は、同じ頂点に置かれた二つの短い対 $\{\vec e,\vec f\}$、$\{\vec e',\vec f'\}$（始点が等しい）であって、どちらも逆向きの二辺の対（$\operatorname{dir}(\vec f)=\operatorname{dir}(\vec e)+2$。すなわち通過 $\iota(\vec e)\to\vec f$ が直進）であり、かつ軸 $\operatorname{ax}(\operatorname{dir}(\vec f))$ と $\operatorname{ax}(\operatorname{dir}(\vec f'))$ が異なる組の個数である（`def_transverse_crossing` を短い対の言葉で言い直したもの。次数 4 の頂点では三つの局所対合のうち一つだけがこれに当たり、$L=1$ の短い対 $\{\vec e,\iota(\vec e)\}$ も逆向きの二辺の対なので同じ規則で数える）。研究管理（2026-10-07）が、この定義でこの等式が辺長 1〜3・四つのスピン構造の全ての標識付きマッチング（辺長 3 で各 34,656 個）について成り立つことを、本文の定義どおりの $\mathbb Q(\zeta_8)[x]$ 上の厳密計算で確かめた（証明ではない）。
8. **局所対合の符号付き和。** 各偶部分グラフ $P$ について $\sum_{\mathcal D:\,P(\mathcal D)=P}(-1)^{t(\mathcal D)}=1$。頂点ごとの積に分かれ、次数 4 の頂点では三つの対合のうち交差するものが一つで $1+1-1=1$、次数 2 では $1$、次数 0 では因子が無い。 研究管理（2026-10-07）が、辺長 1〜3 の全ての偶部分グラフについてこの和が $1$ で、$P$ 上の標識付きマッチングの個数が次数 4 の頂点の個数を $n_4$ として $3^{n_4}$ であることを確かめた。
9. **平方恒等式の合成。** $\operatorname{Pf}(\widehat K^{a,b}(x))=c\cdot\sum_P\chi_{a,b}(h(P),v(P))x^{|P|}=c\,Q^{a,b}_L(x)$、$c=\pm1$ は $\mathcal D_0$ の項の符号（定数項）。 線型順序を $(e,d)\mapsto 2(e-1)+d$ の辞書式に取ると、$\mathcal D_0$ の各対 $\{(e,0),(e,1)\}$ は隣接する位置を占めるので $\operatorname{sgn}(\mathcal D_0)=1$ であり、長い対の成分は $\widehat K_{(e,0),(e,1)}=\zeta_8^{\,2}v_{(e,0)}u_{(e,1)}=\zeta_8^{\,2+r_4(\operatorname{dir}(e,0))-r_4(\operatorname{dir}(e,1))}=\zeta_8^{\,0}=1$（ねじれ偶奇は $(e,0)$ と $(e,1)$ で等しく打ち消し、$r_4(\operatorname{dir}(e,1))=r_4(\operatorname{dir}(e,0))+2$）なので、$c=1$ である。研究管理（2026-10-07）が $\operatorname{Pf}(\widehat K^{a,b}(x))=Q^{a,b}_L(x)$ と $\det K^{a,b}(x)=\det\widehat K^{a,b}(x)=\operatorname{Pf}(\widehat K^{a,b}(x))^2$ を辺長 1〜3・四つのスピン構造で厳密計算により確かめた（証明ではない）。よって $D^{a,b}_L(x)=\det\widehat K^{a,b}(x)=\operatorname{Pf}(\widehat K^{a,b}(x))^2=(Q^{a,b}_L(x))^2$。定数項一の形式的平方根（`claim_formal_square_root_unique`、`claim_formal_square_root_exists`）は $Q^{a,b}_L(x)$ 自身（$Q^{a,b}_L(0)=\chi_{a,b}(0,0)=1$）。最後に `claim_signed_even_subgraph_sector_sum`、`claim_arf_fourier_sign_projection`、高温展開の恒等式を合成して、分配多項式を四つの平方根の符号付き和として書く。

## 背景・前提

- `claim_high_temperature_polynomial_identity`、`claim_high_temperature_sector_decomposition`、Kac--Ward の定義群、離散 Whitney 系の補題群に依存する。
- トーラスで単一の平方根に置き換えない。四つのスピン構造の平方根の符号付き和である。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

有限トーラスの多項式恒等式だけを証明する。Fourier 分解と極限は扱わない。有限データへの式の当てはめは行わない（一般の辺長で閉じない節が出たら、障害を台帳の「前進の記録」へ書いて次の実行可能な節へ進む。方向の再判断は研究管理が行う）。

## 記号の帰属と ℝ 脱出の見込み

- 偶部分グラフ母関数は $\mathbb Z[x]$、各行列とその行列式・Pfaffian は $\mathbb Q(\zeta_8)[x]\subset\overline{\mathbb Q}[x]$ に住む。
- 平方根は解析的分岐でなく、定数項が $1$ の形式的平方根である。
- 実数への脱出はない。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`
- `exact-solution-of-2d-ising-model-lambda/sagemath/check/<対象名>/`（節ごと）
- `exact-solution-of-2d-ising-model-lambda/lean/Ising2DLambda/KacWard/`、`lean/Ising2DLambda/NecSuf/KacWard/`（節ごとに具体版と必要十分版）

## 完了条件

- [ ] 任意の $L\ge1$ と四つのスピン構造について $D^{a,b}_L(x)=(Q^{a,b}_L(x))^2$ が一ステップ一定理で証明されている。
- [ ] 四つの平方根の符号付き和が全巻き付きセクターを係数一で数え、分配多項式に一致することが証明されている。
- [ ] 単一行列式で済む平面公式との混同がない。
- [ ] 各節に SageMath（円分体上の厳密計算）と Lean 二版が付き、`npm run gen`、`npm run check`、`validate-content.ts`、`verify-no-lost-proofs.ts`、`verify-check-linkage.ts`、PDF build、`lake build`、`check-no-sorry.sh` が通る。
