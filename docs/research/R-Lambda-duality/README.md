# ℝ/Λ 双対（概要・現状まとめ）

別セッションでの質問・深掘り用のまとめ。出どころは `integrable-lattice` の cycle 2（方向 D-U2）で観察した現象。
**確立済み（SageMath で計算検証）** と **概念的（解釈・要検証）** を明確に分ける。

記号の集合帰属を常に併記する（CLAUDE.md 厳密性原則）。$\Lambda=\bigoplus_p\mathbb{Z}\ell_p$ は対数順序群（`docs/discussion/対数順序群上の統計力学/`）。

---

## 抽象度の層（各節がどの層の主張かを明示）

議論の混線を防ぐため、以下の 4 層を区別する。各節の主張がどの層に属するかを常に意識する。

| 層 | 対象（所属集合を明示） | 何が言えるか | 使う道具 |
|---|---|---|---|
| **層0**（最抽象）| 単一の整数正方行列 $T\in M_d(\mathbb{Z})$（$d\in\mathbb{N}_{>0}$ 固定） | $Z_N=\operatorname{Tr}(T^N)\in\mathbb{Z}$ の $v_p$ 構造（**定理 P / D-U2**） | 線型代数・整数論のみ。$\mathbb{R}$ 不使用 |
| **層1** | その $T$ が「$L$ 列格子模型の行転送行列」として得られる（$d=$1行の状態数、$L$ 依存）| $Z_N$＝分配関数、$\Phi_N$＝Massieu エントロピーという**解釈** | 層0と同じ数学 |
| **層2** | 行列を1個に固定せず変数 $z$ を持つ族 $T(z)\in M_{d_0}(\mathbb{Z}[z^{\pm1}])$。スペクトル曲線 $P(z,w)=\det(wI-T(z))\in\mathbb{Z}[z^{\pm1},w]$ | Mahler 測度・自由エネルギー・adelic 統合 | **フーリエ変換**（＝並進対称性 $S$ の固有空間分解）・複素解析・積分（$\mathbb{R}/\mathbb{C}$ 脱出）|
| **層3**（最具体）| 六頂点・Ising 等、特定重みの実例 | 具体値計算（$\operatorname{charpoly}=(x-6)(x+2)(x-2)^2$ 等）| 層0–2の特殊化 |

**節と層の対応**: §1–§3（定理 P）は**層0**で完結（フーリエも物理も不要、整数行列1個で閉じる）。§4（Mahler 測度・Bloch 位相・フーリエ）は**層2**（変数 $z$ の族へ登る局面。フーリエはここだけの道具）。§5（六頂点・Ising 例）は**層3**。フーリエ変換は $\mathbb{R}/\Lambda$ 双対の核（定理 P）には不要で、双対を 2 変数 Mahler 測度に接続する層2でのみ現れる。

補足（フーリエ変換の層2定義）: 体 $\mathbb{K}$（$1$ の $L$ 乗根を含む）上の有限次元空間 $V$ に、並進 $S\in GL(V)$（$S^L=\operatorname{id}_V$）が作用するとき、$x^L-1=\prod_k(x-\zeta_L^k)$ が相異なる根をもつことから $V=\bigoplus_{k=0}^{L-1}V_k$（$V_k=\ker(S-\zeta_L^k)$、$\zeta_L=e^{2\pi i/L}$）と固有空間分解する。これがフーリエ変換。$S$ と可換な $T$ は各 $V_k$ を保ち、$T=\bigoplus_z T(z)$（$z=\zeta_L^k\in\mu_L$、有限 $L$ では代数的で $\mathbb{R}$ 不要）とブロック対角化される。これが $T(z)$ の由来。

---

## 0. 一言で

整数転送行列 $T$ の**同一の固有値集合 $\{\lambda_i\}\subset\overline{\mathbb{Q}}$** が、$\mathbb{Q}$ の異なる「素点」で別々の物理量を支配する:

- **アルキメデス素点 $\infty$（絶対値 $|\cdot|_\infty$）** → 自由エネルギー（$\mathbb{R}$, 解析, $N\to\infty$）。
- **各 $p$ 進素点（$|\cdot|_p$）** → Massieu 自由エントロピー $\Phi_N\in\Lambda$ の素因数構造（可算, 決定可能, 有限 $N$）。

「絶対値」と「$p$ 進付値」という同一スペクトルの二つの見方が、$\mathbb{R}$ 側と $\Lambda$ 側に対応する。

---

## 1. セットアップ（確立済み）

- 可積分模型の転送行列 $T\in M_d(\mathbb{Z})$（整数 Boltzmann 重み）。
- $N$ 行 $L$ 列トーラスの分配関数 $Z_N=\mathrm{Tr}\,T^N\in\mathbb{Z}_{>0}$（$L$ 固定）。
- Massieu 自由エントロピー $\Phi_N=\log Z_N\in\Lambda$（素因数分解の指数ベクトル）。
- 固有値 $\{\lambda_i\}\subset\overline{\mathbb{Q}}$（charpoly $\in\mathbb{Z}[x]$ の根）、$Z_N=\sum_i\lambda_i^N$。

検証コード: `integrable-lattice/sagemath/check/D-U2_padic_law/`, `.../potts_phi/`。

---

## 2. $\mathbb{R}$ 側（アルキメデス）— 確立済み（古典）

自由エネルギー密度
$$-\beta f=\lim_{N\to\infty}\frac1{NL}\log Z_N=\frac1L\log\lambda_{\max},$$
$\lambda_{\max}$ は**絶対値最大の固有値**（Perron）。住処は $\mathbb{R}$、解析・連続極限（$\Lambda$ からの脱出 (b) $N\to\infty$）。支配するのは $|\lambda|_\infty$。

---

## 3. $\Lambda$ 側（$p$ 進）— 確立済み（本セッション, 定理候補 D-U2）

各素数 $p$ について、$\Phi_N$ の $\ell_p$ 係数（$=v_p(Z_N)$）は
$$v_p(Z_N)=\mu_{\min}(p)\,N+r_p(N),$$
- $\mu_{\min}(p)=\min_i v_p(\lambda_i)\in\mathbb{Z}_{\ge0}$ = 固有値の**最小 $p$ 進付値** = charpoly の **$p$ 進 Newton 多角形**の一端の辺の傾き（符号は多角形の描き方の規約に依存。曖昧さのない定義は「付値の最小」）。
- $r_p(N)$ = 最終周期的な残差（ただし Skolem–Mahler–Lech 由来の疎な例外指数でスパイクしうる。特殊素数 $p\mid$（模型の対称性位数）で周期増大）。

住処は $\Lambda$（係数は $\mathbb{Z}$）、決定可能・有限 $N$・$\mathbb{R}$ 不使用。支配するのは $|\lambda|_p$（最小付値固有値）。

機構: $Z_N=p^{\mu_{\min}N}\sum_i u_i^N$（$u_i=\lambda_i/p^{\mu_{\min}}$、最小付値群は $p$ 進単位）。単位和は単位係数の線形漸化列で mod $p^k$ 周期的 ⇒ その $v_p=r_p$ が最終周期。

### 3.1 $\Lambda$ 側は $\mathbb{Q}_p$ を必要としない（可算・決定可能であることの精密化）

上の記述で $p$ 進完備体 $\mathbb{Q}_p$（およびその代数閉包 $\overline{\mathbb{Q}_p}$）は説明上の足場にすぎない。$\mathbb{Q}_p$ は濃度 $2^{\aleph_0}$ の**非可算**集合であり、その導入は $\mathbb{R}$ 脱出と同格の非可算化なので、$\Lambda$ 側の主張には**使わない**のが本プロジェクトの立場として正確。D-U2 で実際に触れる対象はすべて可算・有限・決定可能:

- **$v_p(Z_N)\in\mathbb{Z}_{\ge0}$**: $Z_N\in\mathbb{Z}_{>0}$ を $p$ で割り切れる回数。$\mathbb{Z}$ 上の有限手続き。これが $\Phi_N$ の $\ell_p$ 係数そのもの。
- **$\mu_{\min}(p)$**: $\operatorname{char}_T(x)=\sum_j c_j x^j$ の**整数係数の付値 $v_p(c_j)\in\mathbb{Z}$** から、点集合 $\{(j,v_p(c_j))\}$ の下方凸包（有限個の整数点の凸包）として計算。固有値 $\lambda_i$ を個別に構成する必要はなく、埋め込みの選択に依らない組合せ的手続き。
- **固有値の付値の可算な意味づけ**: 「$v_p$ を $\lambda_i\in\overline{\mathbb{Q}}$ へ拡張」も $\overline{\mathbb{Q}_p}$ を経ず、可算数体 $K=\mathbb{Q}(\lambda_i)$ の整数環 $\mathcal O_K$ における素イデアル $\mathfrak p\mid p$ の分解という有限・代数的手続きで済む（$\overline{\mathbb{Q}}$ 自身も可算）。
- **機構**: mod $p^k$ 線形漸化の最終周期性は、位数 $p^{kd}$ の**有限**集合 $(\mathbb{Z}/p^k\mathbb{Z})^d$ 上の鳩の巣論法。

含意: $\Lambda$ 側の非可算性（$\mathbb{Q}_p$）は本質的でなく**除去できる**。対して $\mathbb{R}$ 側（§2）の非可算性は $\log_\mathbb{R}$ と極限 $N\to\infty$ の収束に本質的で**除去できない**。この非対称性が「$\mathbb{R}/\Lambda$ 双対」で $\Lambda$ 側を「決定可能・可算」と呼べる根拠であり、双対の対比をむしろ強める。

---

## 4. 統一像（概念的・要検証）：adelic / 積公式 / Mahler 測度

**仮説的解釈**（まだ厳密命題化していない）:

- 同じ $\overline{\mathbb{Q}}$ の固有値が、$\mathbb{Q}$ の各素点 $v\in\{\infty\}\cup\{p\}$ で別の量を支配する。$\mathbb{R}$ 側（$\infty$）= 自由エネルギー、$\Lambda$ 側（$p$）= $\Phi$ の数論構造。これは**同一スペクトルの異なる完備化への射影**。
- **積公式** $\prod_v|x|_v=1$（$x\in\mathbb{Q}^\times$）が、両側を結ぶ可能性。$\log\lambda_{\max}$（$\infty$ の寄与）と $\{\mu_{\min}(p)\}$（$p$ の寄与）の間に大域的関係があるか？
- **Mahler 測度との関係**: $\log\lambda_{\max}$ は charpoly の支配根の対数で、Mahler 測度 $m(\mathrm{charpoly})=\sum_i\log\max(1,|\lambda_i|_\infty)$ と関連。
- **代数力学**: Lind–Schmidt–Ward の定理「$\mathbb{Z}^d$ 作用の位相的エントロピー = 多項式の Mahler 測度」があり、その **$p$ 進類似（$p$ 進エントロピー / adelic Mahler 測度）** も研究されている。**ℝ/Λ 双対はこの adelic 構造の統計力学版である可能性**（要文献調査・検証）。転送行列のスペクトル ↔ 代数力学の系。

→ ここが「深く理解したい」核心。質問の方向: 積公式の正確な形、Mahler 測度・高さ（height）との対応、代数力学との辞書。

### 4.1 接地（2026-06-26 追記, cycle 4 T1）— ℝ 側は既知で深い

**自由エネルギー＝Mahler 測度**は確立した深い結果:
- スペクトル曲線 $P(z,w)=\det(wI-T(z))\in\mathbb{Z}[z^{\pm},w]$（$T(z)$＝Bloch 位相 $z$ つき転送行列）。
- $-\beta f=\log m(P)$（$m$＝Mahler 測度）。**Lind–Schmidt–Ward**（$\mathbb{Z}^d$ 作用のエントロピー＝Mahler 測度）の格子版。
- **Ising で精密化**: arXiv:2407.19531 / Phys. Rev. E 110, 054134 (2024)「Mahler measures, elliptic curves and L-functions for the free energy of the Ising model」。正方/三角/六角 Ising の自由エネルギー＝Laurent 多項式の Mahler 測度、特殊温度で楕円曲線 Hasse–Weil $L$、臨界点で Dirichlet $L$。
- 代数力学エントロピー＝Mahler 測度成長（arXiv:2109.08217）。

したがって **ℝ 側双対（自由エネルギー＝アルキメデス Mahler 測度）は既知**。本プロジェクトの寄与は **Λ 側（有限 N の $v_p$ 構造＝同じ $P$ の非アルキメデス/$p$ 進 Mahler 測度）との同定**（予想, D-U2 命題 A は厳密）。命題形は `integrable-lattice/outputs/reports/cycle4_T1_R_Lambda_mahler.md`。

質問の核（更新）: $p$ 進 Mahler 測度（Besser–Deninger, $p$ 進エントロピー）と $\mu_{\min}(p)$ の厳密対応。同一 $P$ のアルキメデス Mahler（ℝ自由エネルギー）と $p$ 進 Mahler（Λ の $\Phi$ 構造）を結ぶ積公式。

### 4.2 接地（2026-06-28 追記, cycle 6 T1）— Λ 側も既知理論だった

**Λ 側は予想でなく既存理論**: 周期点数 $a_L=\prod_{z^L=w^L=1}P\in\mathbb{Z}$ について、
- ℝ側 $\frac1{L^2}\log|a_L|\to m(P)$（アルキメデス Mahler＝自由エネルギー, LSW）。
- Λ側 岩澤塔 $L=p^n$ での $v_p(a_{p^n})$ の線形成長率 ＝ **Deninger の $p$ 進エントロピー** ＝ **Besser–Deninger の $p$ 進 Mahler 測度** ＝ **岩澤 $\mu_p$ 不変量**。

文献: Besser–Deninger "p-adic Mahler measures"; Deninger "p-adic entropy and a p-adic Fuglede–Kadison determinant"; "p-adic Mahler measure and ℤ-covers of links"（torsion 成長・Alexander 多項式・p 進エントロピー・μ_p の balance formula）。
⇒ ℝ/Λ 双対は **同一 $P$ の二つの素点での Mahler 測度**として両側とも確立理論に乗る。D-U2 はその有限・決定可能な顔。検証 `integrable-lattice/sagemath/check/cycle6_T1_padic_mahler/`, 命題 `integrable-lattice/outputs/reports/cycle6_T1_padic_mahler_grounding.md`。
注意: 例 $P=5-(z+1/z)-(w+1/w)$ は小素数で μ_p=0（p 進自明）。非自明 μ_p には $P\bmod p$ が p 冪根上に零点をもつ $P$ が必要。

---

## 5. 具体例（本セッション, 確立済み）

六頂点, 重み $(a,b,c)=(1,1,2)$, $L=2$: $\mathrm{charpoly}(T)=(x-6)(x+2)(x-2)^2$, 固有値 $\{6,-2,2,2\}$。

- $\mathbb{R}$ 側: $\lambda_{\max}=6$ ⇒ $-\beta f=\frac12\log 6$。
- $\Lambda$ 側: $v_2$: 全固有値 $v_2=1$ ⇒ $\mu_{\min}(2)=1$, 残差 $\equiv2$ ⇒ $v_2(Z_N)=N+2$。$v_3$: $v_3(6)=1$ だが $v_3(\pm2)=0$ ⇒ $\mu_{\min}(3)=0$, 周期2。
- 同じ $\{6,-2,2,2\}$ から、絶対値最大(6)が自由エネルギー、各 $p$ 進付値が $\Phi$ の素因数構造を出す。

他例（Potts q=3 など）も `sagemath/check/` 参照。

---

## 6. 未解決・質問の種（別セッション用）

1. 積公式の正確なステートメント: $\lambda_{\max}$ と $\{\mu_{\min}(p)\}_p$ を結ぶ大域恒等式はあるか（Mahler 測度・高さ経由か）。
2. SML 例外指数の意味（物理的・数論的）。
3. 代数力学（Lind–Schmidt–Ward, adelic Mahler 測度）との厳密な辞書。転送行列 ↔ $\mathbb{Z}^d$ 作用。
4. 非整数（代数的）重みへの拡張: 固有値は $\overline{\mathbb{Q}(x)}$、Newton 多角形・Mahler 測度はどうなるか。
5. 八頂点（楕円, theta 関数）の場合: 固有値が楕円的になり、ℝ/Λ 双対は崩れるか・別形になるか。
6. $\Lambda$（対数順序群）の言葉で双対を書くと何が言えるか（$\Phi$ は既に $\Lambda$、自由エネルギーは $\mathbb{R}$。双対を $\Lambda$ 内で定式化できるか）。
7. 形式検証: $\Lambda$ 側（決定可能）はそのまま機械検証可能。$\mathbb{R}$ 側との対応のどこまでが可算で言えるか。

---

## 7. 関連リポジトリ内資料

- `integrable-lattice/outputs/candidates/D-U2_vp_law_theorem_candidate.md`（$\Lambda$ 側の定理候補）。
- `integrable-lattice/sagemath/check/D-U2_padic_law/`（計算検証）。
- `docs/discussion/対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md`（$\mathbb{R}$ 脱出の隔離・転送行列）。
- `docs/discussion/可算性の効用/`（可算/$\mathbb{R}$ = 決定可能性の境界）。

---

## 8. $\Lambda$-内部定式化（6-6 の確定, 層0/1）

6-6（双対を $\Lambda$ の言葉で書く）を、確立済みの定理 P だけで層0/1で確定する。$\mu_p$・積公式（層2）に非依存。6-1（積公式）はこの土台の上で初めて意味を持つ。

### 8.1 $\Lambda$ 側は単一の $\Lambda$-内部命題

**主張 1（$\Lambda$-傾き $M$ の well-defined 性＝有限台）.** $T\in M_d(\mathbb{Z})$、$\det T\ne0$ とする。
$$M:=\sum_{p\in\mathcal P}\mu_{\min}(p)\,\ell_p\in\Lambda\otimes\mathbb{Q}\quad(\mu_{\min}(p)\in\mathbb{Z}\ \forall p\ \text{なら}\ \in\Lambda;\ \text{audit (2)}).$$
すなわち $\mu_{\min}(p)>0$ となる $p$（＝台）は有限個。
*証明*: $\mu_{\min}(p)=\min_i v_p(\lambda_i)>0$ なら全固有値が $v_p>0$、よって $v_p(\det T)=\sum_i v_p(\lambda_i)\ge d>0$、ゆえ $p\mid\det T$。$\det T\in\mathbb{Z}\setminus\{0\}$ の素因数は有限。∎（$\det T=0$ は $0$ 固有値を分離した $T'$ で同様。）

**主張 1′（$M$ の台の陽な特徴づけと計算容易性）.** $\chi_T(x)=x^d+a_{d-1}x^{d-1}+\dots+a_0\in\mathbb{Z}[x]$（$T\in M_d(\mathbb{Z})$ ゆえ固有値は代数的整数, $\chi_T$ は monic 整数係数）に対し $g:=\gcd(a_0,a_1,\dots,a_{d-1})\in\mathbb{Z}$ とおくと
$$\{p:\mu_{\min}(p)>0\}=\{p:p\mid g\}.$$
*証明*: $\mu_{\min}(p)>0\iff$ 全固有値が $v_p>0\iff$ 全対称式 $a_k\ (k<d)$ が $v_p>0\iff \chi_T\equiv x^d\ (\mathrm{mod}\ p)\iff p\mid g$。∎
$g$ は $T$ から決まる**固定整数**（$N$ 非依存, $g\mid a_0=\pm\det T$）で、傾き $M$ の台はその素因数という有限・容易な集合。これは $\Phi_N$ の**全台** $\{p:v_p(Z_N)>0\}$（$Z_N\sim\lambda_{\max}^N$, $N$ で発散, 列挙は分解困難）と対照的：$M$ の台の決定は固定小整数 $g$ 一回の分解、メンバーシップ $p\mid g$ は割り算一回で分解不要。値 $\mu_{\min}(p)$ 自体は指定 $p$ の Newton 多角形で個別に得る。例：六頂点 $L=2$ で $\chi_T=x^4-8x^3+8x^2+32x-48$, $g=\gcd(8,8,32,48)=8$, $\{p\mid8\}=\{2\}$（$3\mid\det T=48$ だが $3\nmid g$ ゆえ $\mu_{\min}(3)=0$）。

**主張 2（$\Lambda$-内部双対法則）.** 各 $N\in\mathbb{N}_{>0}$ に対し
$$\Phi_N=N\cdot M+R(N),\qquad R(N):=\sum_{p}r_p(N)\,\ell_p\in\Lambda,$$
$r_p(N):=v_p(Z_N)-\mu_{\min}(p)N\in\mathbb{Z}_{\ge0}$（床の上の超過分, 系より非負）、各座標は **$p$ で非退化なら**（下記 audit (1)）$N$ について最終周期的。これは定理 P（$v_p(Z_N)=\mu_{\min}(p)N+r_p(N)$）の全 $p$ 集約。$R(N)\in\Lambda$（有限台）は固定 $N$ で $Z_N\in\mathbb{Z}_{>0}$ の素因数が有限だから。

**閉じた形（前提 $\mu_{\min}(p)\in\mathbb{Z}$; audit (2)(3)）.** 傾き含量整数 $c:=\prod_p p^{\mu_{\min}(p)}=\prod_{p\mid g}p^{\mu_{\min}(p)}\in\mathbb{Z}_{>0}$（$M$ に対応, $T$ で固定・$N$ 非依存）を使うと、全 $p$ で $v_p(Z_N)\ge N\mu_{\min}(p)$ ゆえ $Z_N/c^N\in\mathbb{Z}_{>0}$ で
$$R(N)=\log(Z_N/c^N)\in\Lambda,$$
すなわち $R(N)$ は整数 $Z_N/c^N$ の素因数分解（$\Phi_N=N\log c+\log(Z_N/c^N)=N M+R(N)$）。$R(N)$ の台 $\{p:r_p(N)>0\}=(Z_N/c^N$ の素因数$)$ は $N$ で増え列挙困難（$Z_N/c^N$ の分解）だが、法則は列挙を要さず名指し $p$ の $r_p(N)$ を $\bmod p^k$ 漸化で個別に与える。例：六頂点 $L=2$ で $c=2$, $Z_N/2^N=3^N+(-1)^N+2$, $R(N)=\log(3^N+(-1)^N+2)$（$N{=}1$: $4{=}2^2$, $N{=}2$: $12{=}2^2\cdot3$）。

⇒ 列 $(\Phi_N)_N\subset\Lambda$ は傾き $M\in\Lambda$ で**最終的に $\Lambda$-線形**。$\mathbb{R}$ 不使用。

**系（傾き素点は恒久的因子）.** $p\mid g$（$\iff\mu_{\min}(p)>0$）なら全 $N\ge1$ で $p\mid Z_N$。*証明*: 超距離不等式で $v_p(Z_N)=v_p(\sum_i\lambda_i^N)\ge\min_i N\,v_p(\lambda_i)=N\mu_{\min}(p)>0$、$Z_N\in\mathbb{Z}$ ゆえ $\ge1$。∎ よって $r_p(N)\ge0$ は床 $\mu_{\min}(p)N$ の上に乗る（$v_p(Z_N)\ge\mu_{\min}(p)N$, 線形成長）。対して $p\nmid g$（$\mu_{\min}(p)=0$, 例 六頂点 $p=3$: $Z_N\equiv1+(-1)^{N+1}\bmod3$, $N$ 偶のみ割る）は $N$ 依存で割ったり割らなかったりする残差素点。傾き $M$ の台（$T$ で固定・有限）＝恒久的因子、残差 $R(N)$ の台（$N$ 依存）＝断続的因子。

### 8.1a 素点ごとのアクセス（算法）と前提の精密化（audit）

**素点ごとのアクセス（名指し $p$, 分解不要）.** $Z_N=\mathrm{Tr}(T^N)$ は $\chi_T$ を特性多項式とする $\mathbb{Z}$-線形漸化列。$p$ を固定して:
1. $T^N\bmod p^k$ を繰り返し二乗法（$O(\log N)$ 回の行列積, 各 $O(d^3)$ の $\bmod p^k$ 乗算）で計算しトレース ⇒ $Z_N\bmod p^k$。
2. $Z_N\equiv0\ (p^j),\not\equiv0\ (p^{j+1})$ の $j=v_p(Z_N)$。$k>v_p(Z_N)$ で確定。

コスト $\mathrm{poly}(d,\log N,\log p,k)$。$p\mid g$ では $v_p(Z_N)\approx\mu_{\min}(p)N=\Theta(N)$ ゆえ $k=\Theta(N)$、生計算は $\mathrm{poly}(N)$（分解 $\exp(\Theta(N^{1/3}))$ より桁違いに安い）。近道：$\mu_{\min}(p)$ は Newton 多角形で一度、超過 $r_p(N)$ は非退化なら最終周期ゆえ周期一回計算で以後 $O(1)$。**$\Phi_N$ 全体（＝ $Z_N$ 分解）を経ず、$p$ を名指しして座標だけ取る**のがこの構図。

**audit（無条件では不成立・要前提）.**
- **(1) 最終周期性は非退化前提.** 進行 $N\equiv a\ (\mathrm{mod}\ M)$ 上で $Z_N$ は $p$ 進解析関数 $f_a(t)$（$t=(N-a)/M\in\mathbb{Z}_p$）に補間される。$f_a$ が $\mathbb{Z}_p$ に零点を持たないとき $r_p(N)$ は最終周期。零点 $t_0\in\mathbb{Z}_p$ を持つと（Skolem–Mahler–Lech 退化）、$t_0$ に $p$ 進収束する整数 $N$ に沿い $v_p(Z_N)\to\infty$、$r_p$ は非有界・非周期。一般の周期上界・例外集合は SML 由来で非可効（決定可能なのは各 $N$ の $v_p(Z_N)$ 点別計算まで）。
- **(2) $M\in\Lambda$ は $\mu_{\min}(p)\in\mathbb{Z}$ 前提.** $\mu_{\min}(p)=\min_i v_p(\lambda_i)$ は Newton 多角形の最小傾きで分数になりうる（分岐拡大の固有値）。一般には $M\in\Lambda\otimes\mathbb{Q}$、$M\in\Lambda$ は全 $p$ で $\mu_{\min}(p)\in\mathbb{Z}$（固有値が有理整数等）のとき。$\{p:\mu_{\min}(p)>0\}=\{p\mid g\}$（主張1′）は分数でも成立（閾値判定）。
- **(3) $R(N)=\log(Z_N/c^N)$ も (2) 前提.** $c=\prod_p p^{\mu_{\min}(p)}$ は $\mu_{\min}\in\mathbb{Z}$ でないと有理数ですらない。加えて $\Phi_N=\log Z_N\in\Lambda$ には $Z_N>0$ が要る（$Z_N=0$ は素因数分解なし）。真の転送行列（非負・原始的）は Perron–Frobenius で $Z_N=\mathrm{Tr}\,T^N>0$ ゆえ全零進行は排除されるが、劣支配固有値の分数付値・退化は残りうる。
- **反例（(1)-(3) を同時に破る）.** $\chi_T=x^2-2$（$T=\bigl[\begin{smallmatrix}0&2\\1&0\end{smallmatrix}\bigr]$）: $Z_N=(\sqrt2)^N+(-\sqrt2)^N$、$N$ 奇で $0$（全奇数進行が例外, (1)破綻）、$N$ 偶で $2^{N/2+1}$。$\mu_{\min}(2)=v_2(\sqrt2)=1/2\notin\mathbb{Z}$（(2)破綻）、$c=\sqrt2\notin\mathbb{Q}$（(3)破綻）。ただし非負行列でないので真の転送行列ではない。

**六頂点が綺麗な理由.** 固有値 $\{6,-2,2,2\}\subset\mathbb{Z}$ ゆえ $\mu_{\min}\in\mathbb{Z}$（(2)(3)成立）、各素点で $r_p$ 純周期（(1)成立）。一般の可積分模型（無理代数的 Perron 根）ではこれらは前提付きで、無条件で言えるのは床 $v_p(Z_N)\ge\mu_{\min}(p)N$（系）と各 $N$ の点別計算可能性のみ。

### 8.2 $\mathbb{R}$ 脱出の隔離

**観察 3（スペクトル・データは可算）.** $\lambda_i\in\overline{\mathbb{Q}}$、$\bar\lambda_i\in\overline{\mathbb{Q}}$ ゆえ $|\lambda_i|_\infty^2=\lambda_i\bar\lambda_i\in\overline{\mathbb{Q}}\cap\mathbb{R}_{\ge0}$、したがって $|\lambda_i|_\infty\in\overline{\mathbb{Q}}\cap\mathbb{R}_{\ge0}$、$\lambda_{\max}\in\overline{\mathbb{Q}}\cap\mathbb{R}_{>0}$（絶対値も最大固有値も代数的・可算）。

**観察 4（唯一の $\mathbb{R}$ 脱出は $\log_{\mathbb{R}}$）.** $-\beta f=\frac1L\log_{\mathbb{R}}\lambda_{\max}$ で $\lambda_{\max}\in\overline{\mathbb{Q}}$ は可算、$\mathbb{R}$ へ出るのは $\log_{\mathbb{R}}:\overline{\mathbb{Q}}_{>0}\to\mathbb{R}$ 一つ。Baker により代数的 $\alpha\ne0,1$ で $\log_{\mathbb{R}}\alpha$ は超越、ゆえ一般に $\log_{\mathbb{R}}\lambda_{\max}\notin\overline{\mathbb{Q}}$。

**観察 5（同一スペクトルの二種の対数）.** 双対の両側は共通の有限多重集合 $\{\lambda_i\}\subset\overline{\mathbb{Q}}$ の「対数」：$\Lambda$ 側は $\log:\mathbb{Q}_{>0}\to\Lambda$（$\min$-$v_p$ 集約 $=M$、厳密・可算）、$\mathbb{R}$ 側は $\log_{\mathbb{R}}:\overline{\mathbb{Q}}_{>0}\to\mathbb{R}$（$\max$-$|\cdot|_\infty$ の $\lambda_{\max}$、超越脱出）。

**観察 6（脱出が消える条件）.** $\lambda_{\max}\in\mathbb{Q}_{>0}$ のときに限り $\log_{\mathbb{R}}\lambda_{\max}=\sum_p v_p(\lambda_{\max})\ell_p\in\Lambda$ に落ち $\mathbb{R}$ 脱出が消える。例：六頂点 $(1,1,2),L=2$ で $\lambda_{\max}=6$、$-\beta f=\frac12(\ell_2+\ell_3)\in\Lambda\otimes\mathbb{Q}$。一般の可積分模型では $\lambda_{\max}$ は既約因子の Perron 根＝代数的無理数で脱出は不可避。

**観察 7（$\log\lambda_{\max}$ と $\rho(M)$ の物理的意味＝別概念）.** 実現 $\rho:\Lambda\to\mathbb{R}$, $\rho(\sum a_p\ell_p)=\sum a_p\log_{\mathbb{R}}p$ で両側を $\mathbb{R}$ に並べる。
- $\log_{\mathbb{R}}\lambda_{\max}=\max_i\log|\lambda_i|_\infty$（アルキメデス）＝ $Z_N$ の**指数的成長率** ＝ **自由エネルギー密度** $-\beta f=\frac1L\log\lambda_{\max}$。物理の実体（エントロピー・比熱・相転移）はここ。
- $\rho(M)=\sum_p\mu_{\min}(p)\log p=\log_{\mathbb{R}}c$（$c=\prod_p p^{\mu_{\min}(p)}$, 非アルキメデスの $\min$-$v_p$ を集約）＝ 成長率でなく **$c^N\mid Z_N$ の割り切れの床**。物理的には $\mu_{\min}(p)>0\iff T\bmod p$ 冪零（$\chi_T\equiv x^d\bmod p$）＝ **重みの自明な乗法的含量**（全体規格化・自由対称群の位数, 各行あたり因子 $c$）で、相互作用が生む自由エネルギーではない。
- 一般に $\rho(M)\ne\log\lambda_{\max}$。同一 $\{\lambda_i\}$ の二付値汎関数（$\max$-$|\cdot|_\infty$ vs $\min$-$v_p$）で、$\log\lambda_{\max}=\rho(M)+(\text{アルキメデス・ドリフト})$、主要物理は後者。
- 例：六頂点 $(1,1,2),L=2$ は成分が全偶で $T=2T'$（$T'$ 固有値 $\{3,-1,1,1\}$）。$c=2$ は重み $c{=}2$ の全体因子、$\rho(M)=\log2\approx0.693$（自明含量）、$\log\lambda_{\max}=\log6\approx1.792$（自由エネルギー$\times L$）、$\log6=\log2+\log3$ で真の相互作用分は $\log3$。

### 8.3 注意：$\lambda_{\max}\in\mathbb{Q}$ は可積分性・閉形式と独立（三軸の分離）

$\lambda_{\max}\in\mathbb{Q}$（固定 $L$ で charpoly が有理 Perron 根をもつ、$\iff$ 整数根、決定可能な算術的条件）は、次の三つの独立な軸のうち**軸 C のみ**の性質で、他を含意しない。

- **軸 A：可積分性**（層1）＝ 転送行列の族 $T(u)$ が Yang–Baxter を満たす。単一行列の一根が有理かどうかとは無関係。
- **軸 B：閉形式／可解性**（層2）＝ 熱力学極限 $L,N\to\infty$ の $-\beta f$ が明示式を持つか。これは別個の達成で、可積分でも保証されない（`07_Λ帰属と可解性は別.md` と同じ独立性）。
- **軸 C：有限 $L$ スペクトルの算術**（層0）＝ $\lambda_{\max}\in\mathbb{Q}$ など、charpoly の $\mathbb{Q}$ 上分解。

$\lambda_{\max}\in\mathbb{Q}$ が与えるのは「その有限 $L$ で $\mathbb{R}$ 脱出が消え $-\beta f\in\Lambda\otimes\mathbb{Q}$」だけ（観察 6）。極限 $L\to\infty$ は依然 $\mathbb{R}$ を要し、$\lambda_{\max}\in\mathbb{Q}$ は $L$ 増大で一般に崩れる不安定な性質。可積分性も閉形式も含意しない。

### 8.4 残タスク（確定に向けて）

1. 主張 1・2 を正式命題として（$\det T=0$ 縮退込みで）証明整備。
2. 観察 3–6 を命題化（$|\lambda_i|_\infty\in\overline{\mathbb{Q}}$、$\log_{\mathbb{R}}$ の超越性、脱出消滅条件 $\lambda_{\max}\in\mathbb{Q}$、三軸独立）。
3. $M\in\Lambda$（$\min$-$v_p$）と $\lambda_{\max}\in\overline{\mathbb{Q}}$（$\max$-$|\cdot|_\infty$）を、同一 $\{\lambda_i\}$ 上の二つの付値汎関数として並置する構造的定式化（積公式 6-1 を使わずに言える対）。
4. 2 から 6-7（形式検証）が従う：$\Lambda$ 側（主張 1・2）は決定可能・機械検証可能、$\mathbb{R}$ 側は $\log_{\mathbb{R}}\lambda_{\max}$ の一点のみ検証外、という境界の確定。

**目標の分解（「$\Phi_N$ を各 $N$ 陽に書き $\mathbb{R}$-閉形式へ極限」という代替ゴールの分析）.** これは独立な二条件に割れる。
- **(a) $\Phi_N$ を各 $N$ 陽に（軸 C）**：傾き $M$ は Newton 多角形で常時陽（前提 $\mu_{\min}\in\mathbb{Z}$, audit 2）、残差 $R(N)=\log(Z_N/c^N)$ は素点ごとには非退化で最終周期（audit 1）だが**全台を一様に陽＝ $Z_N/c^N$ の分解**（$N$ 依存・分解困難）で、特殊族（例 $3^N+(-1)^N+2$）以外は一様閉式なし。
- **(b) $\mathbb{R}$-閉形式への極限（軸 B）**：極限は常に $\frac1{NL}\rho(\Phi_N)=\frac1{NL}\log Z_N\to\frac1L\log\lambda_{\max}\to m(P)$ で**$\lambda_{\max}$（アルキメデス）だけが支配**。閉形式（定義 Y, Onsager）を持つ $\iff$ 模型が厳密可解。
- **核心**：$\rho$ は $\Phi_N$ を $|\cdot|_\infty$ の $\lambda_{\max}$ に潰し $\Lambda$-構造（$M$・分解）を捨てる。ゆえ **$\Phi_N$ を $\Lambda$-陽に書けても極限の閉形式性には効かない**。(a)(b) は §8.3 の軸 C・軸 B で独立。
- **帰結**：「$\mathbb{R}$ 脱出の**隔離**」がゴールなら §8.6（$\rho$ に潰れる一点）で達成済みで 6-1 は不要。「$\Lambda$ の決定可能データ $\{\mu_{\min}(p)\}$ が $-\beta f$ を**縛る**」がゴールなら、極限は $\lambda_{\max}$ に閉じるので非アルキメデス→アルキメデスの橋＝**6-1 が必須**。極限を取るだけなら $\log Z_N$ の数値評価に等しく $\Lambda$ は寄与しない。

### 8.5 閉形式の二種：$\Lambda$-閉形式 vs 解析的閉形式

「閉形式」は許す演算集合 $\mathcal F$ に相対的（$\mathcal F$ 抜きでは無定義）。双対の両側で $\mathcal F$ が異なるので二種に分ける。

**定義 X（$\Lambda$-閉形式）.** 演算集合 $\mathcal F_\Lambda:=\{$ $\Lambda$ の $\mathbb{Z}$-線形結合; $\log:\mathbb{Q}_{>0}\to\Lambda$（素因数分解）; $\mathbb{Z}[x]$ の Newton 多角形による $v_p$; 有限多重集合の $\min/\max$; $\bmod p^k$ 線形漸化＋最終周期の有限記述; 整数算術・有限場合分け $\}$（$\lim,\int,\exp,\log_{\mathbb{R}},\mathbb{R}/\mathbb{C}$ を含まない）。量・列が $\mathcal F_\Lambda$ の有限表現で書け値が $\Lambda$（または $\Lambda\otimes\mathbb{Q}$）に住むとき **$\Lambda$-閉形式を持つ**という。**決定可能・機械検証可能・可算・極限なし**。

**定義 Y（解析的閉形式＝通常の閉形式）.** $\mathcal F_{\mathbb{R}}:=\{$ 体演算, 根号, $\exp,\log_{\mathbb{R}}$, 固定領域の定積分, 指定特殊関数（楕円積分・$L$ 函数等）, $\lim$ $\}$。量が $\mathcal F_{\mathbb{R}}$ の有限表現で書け値が $\mathbb{R}/\mathbb{C}$ に住むとき **（解析的）閉形式を持つ**という。一般に**非可算・極限/積分を含み決定不能**。Onsager 解はこれ。

**対応**:

| | 有限（極限なし） | 熱力学極限（極限あり） |
|---|---|---|
| $\mathbb{R}$ 側 | $-\beta f_L=\frac1L\log_{\mathbb{R}}\lambda_{\max}(L)$（$\lambda_{\max}\in\overline{\mathbb{Q}}$）| $m(P)$／Onsager, $\int$ ＝**解析的閉形式**（定義 Y）|
| $\Lambda$ 側 | $\Phi_N=N\cdot M+R(N)$, $M\in\Lambda$ ＝**$\Lambda$-閉形式**（定義 X, 全 $N$ 厳密）| $\mu_p$（岩澤, 層2, 未確定）|

**要点**:
- $\Lambda$-閉形式は極限を要しない：成長率 $M=\sum_p\mu_{\min}(p)\ell_p\in\Lambda$ は単一 charpoly の Newton 多角形（有限代数）で得る。$\mathbb{R}$ 側が熱力学率に極限 $\frac1L\sum\to\int$ を要し $\int$ が出る（Onsager 解は極限を取った後の量ゆえ積分が現れる。有限 $L$ には有限和 $\sum$ しかなく $\int$ は $L\to\infty$ の痕跡）のと対照的。
- 同じ「閉形式」でも $\Lambda$-閉形式（定義 X, 決定可能・可算・極限なし）と解析的閉形式（定義 Y, $\mathbb{R}$・極限・積分）は別物。$\S8.3$ 軸 B「閉形式」は定義 Y を指す。$\Lambda$ 側の $\Phi_N=NM+R(N)$（主張 2）は定義 X の意味で既に閉形式が**ある**——これが $\Lambda$ 側の「解けている」の正確な意味。
- 注意：$\Lambda$ 側の熱力学極限（岩澤塔 $L=p^n\to\infty$ の $\mu_p$, 層2）は $\Lambda$-閉形式で済む保証がない（未確定）。$\Lambda$-閉形式で書けているのは有限 $L$・全 $N$ の段まで。

### 8.6 「$\Lambda$-閉形式列の収束先＝$\mathbb{R}$-閉形式」は真、ただし対象は $\Phi_N$（傾き $M$ ではない）

「$\Lambda$-閉形式の列を作れば、その収束先が $\mathbb{R}$-閉形式に対応する」——この picture は正しい。ただし列として**何を取るか**で真偽が分かれる。

**実現写像（新規, 集合明示）.** $\rho:\Lambda\to\mathbb{R}$ を $\rho(\sum_p a_p\ell_p):=\sum_p a_p\log_{\mathbb{R}}p$（$a_p\in\mathbb{Z}$, 有限台）で定める。順序群の単射準同型で、$\log_{\mathbb{R}}$ による**唯一の $\mathbb{R}$ 脱出**。$\log_{\mathbb{R}}Z_N=\rho(\Phi_N)$（$\Phi_N\in\Lambda$ は素因数分解, $\log_{\mathbb{R}}$ は実対数）。

**(A) 完全な $\Phi_N$ を取れば真.** 各 $\Phi_N\in\Lambda$ は定義 X の意味で $\Lambda$-閉形式（$Z_N$ の厳密素因数分解, 決定可能, 有限台）。列を $\rho$ で実現・規格化すると
$$\frac1{NL}\rho(\Phi_N)=\frac1{NL}\log_{\mathbb{R}}Z_{N,L}\xrightarrow[N,L\to\infty]{}\log m(P)=-\beta f.$$
各項は $\Lambda$-閉（可算・決定可能）、極限（$=\rho$＋$N,L\to\infty$）が $\mathbb{R}$-閉形式（Onsager）。**これが「$\Lambda$-閉形式列の収束先＝$\mathbb{R}$-閉形式」の正しい実現**。

**(B) 傾き $M$ を取ると偽.** $\rho(M)=\sum_p\mu_{\min}(p)\log_{\mathbb{R}}p\ne\log_{\mathbb{R}}\lambda_{\max}$。$M$ は非アルキメデス的な影（$\min$-$v_p$）のみを射影し、自由エネルギーを与えるアルキメデス的成長（$\max$-$|\cdot|_\infty=\lambda_{\max}$）を落とす。

**(B) が落ちる機構（六頂点 $\{6,-2,2,2\}$, $L=2$）.** $M=\ell_2$（$\mu_{\min}(2)=1,\mu_{\min}(3)=0$）ゆえ $\rho(M)=\log2\approx0.693$、一方 $\log\lambda_{\max}=\log6\approx1.792$。差 $\log3$ は $R(N)$ に潜む：$\rho(R(N))=\log Z_N-N\rho(M)\approx N\log3$ は **$N$ 線形で非有界**。各座標 $r_p(N)$ は最終周期的（有界）なのに、台が $N$ で増える（$Z_N$ が新素因数を獲得する）ため $\rho$ の無限和が線形に伸びる。すなわち **$R(N)$ は「各素点で有界・アルキメデス実現で非有界」**。自由エネルギーの分解：$\log\lambda_{\max}=\rho(M)+(\text{$R$ のアルキメデス・ドリフト})$、主要項は後者。

**帰結（対応の正確な形）.** 同一の整数列 $Z_{N,L}$ を、素点 $\infty$ で読むと（真の極限を経て）$\mathbb{R}$-閉形式、各素点 $p$ で読むと（極限なしで）$\Lambda$-閉の傾き $M$。「収束先が $\mathbb{R}$-閉形式」は $\Phi_N$ を丸ごと $\rho$ 実現した**アルキメデスの顔**の話であり、$\S8$ の非アルキメデス傾き $M$ とは**別射影**。$\S8.5$ 表の $\mathbb{R}$ 側・$\Lambda$ 側は「同じ $\Phi_N$ の二素点射影」であって、片方の極限がもう片方になるのではない。

**計算量の注意（決定可能性は素因数分解を経由しない）.** $\Phi_N\in\Lambda$ を**全座標同時に**書き下すことは $Z_N=\mathrm{Tr}(T^N)\sim\lambda_{\max}^N$（約 $N\log_2\lambda_{\max}$ ビット）の完全素因数分解に等しく、$\{p:v_p(Z_N)>0\}$ の列挙は一般に困難。しかし双対の中身はどれも分解を経由しない：(i) 傾き $M$ は charpoly $\in\mathbb{Z}[x]$ の Newton 多角形（$Z_N$ に触れない）、(ii) 指定した $p$ の座標 $v_p(Z_N)$ は $\bmod p^k$ 線形漸化で直接（他の素因数を知らずに）、(iii) アルキメデス実現 $\rho(\Phi_N)=\log_{\mathbb{R}}Z_N$ は整数 $Z_N$ への実対数一発（極限は $\lambda_{\max}$ が支配、Perron）。困難なのは「$v_p>0$ となる $p$ を**列挙**する」方向だけで、定理はこれを要求しない。列挙は完全分解と**多項式時間で等価**（多重度 $v_p$ は $p$ 既知なら除算で安く、ボトルネックは素数の発見で両者共通）：列挙コストは GNFS で $\exp(\Theta(N^{1/3}(\log N)^{2/3}))$（$\log_2 Z_N=\Theta(N)$, 超多項式）。対して指定 $p$ の $v_p(Z_N)$ は $\bmod p^k$ 漸化で多項式・周期後 $O(1)$。双対に要る素点は「$Z_N$ を割る全 $p$」でなく、$M$ は $p\mid\det T$（有限, $N$ 非依存）、$r_p$ は名指しの $p$ のみ——列挙は登場しない。$\Lambda$ は**値の住処**を保証し、決定可能性は**素点ごと**のアクセス（Newton 多角形＋固定 $p$ の $\bmod p^k$ 漸化）から来る。例：六頂点 $L=2$ で $Z_{100}=6^{100}+2^{100}+2^{101}$（約78桁, 大素因数未知）でも $v_2=102$（$N+2$）・$M=\ell_2$・$\log_{\mathbb{R}}Z_{100}\approx100\log6$ は分解せず得られる。

---

## 9. ゴールの再設定：可解系の族の数論的特徴づけ（§8.4 の「傍流」評価を撤回）

**区別**：「個々の系を解く普遍解法」（存在しない・不要）と「**解ける系の族を数学的に特徴づける**」は別問題。後者がゴール。§8.4 で双対を可解性に対し「傍流」と評したのは、この二つを混同したための誤りで撤回する。族の特徴づけには数論的視点（双対の $\Lambda$ 側）が中心的に効く。

### 9.1 可解性は曲線 $\{P=0\}$ の数論型で決まる

$-\beta f=\log m(P)$、$P\in\mathbb{Z}[z^\pm,w]$ スペクトル曲線。Onsager 型が特殊なのは**数論的に特殊**だから：
- $m(P)$ が解析的閉形式（定義 Y）を持つ $\iff$ $\{P=0\}$ が数論的に特殊 $\iff$ $m(P)$ が**ある $L$ 函数の特殊値**（Boyd–Deninger–Beilinson の Mahler 測度＝$L$ 値理論）。
- **閉形式の「型」は種数・数論型で決まる**：種数 0（有理, 六頂点）→ 初等/二重対数；種数 1（楕円, 八頂点 Baxter）→ 楕円曲線の $L'(E,0)$（例 $m(1+z+z^{-1}+w+w^{-1})=L'(E,0)$, Boyd 予想/Rogers–Zudilin）；高種数・モジュラー → より難しい特殊値。

⇒「可積分で解ける物理系とは何か」＝「スペクトル曲線 $P$ の数論型（種数・還元・CM・モジュラー性）は何か」。これが求める特徴づけの形。

### 9.2 $\Lambda$ 側は数論型の決定可能プローブ

同じ $P$ の $p$ 進データが数論型を**決定可能に検出**：有限体点数 $N_p=\#\{(z,w)\in\mathbb{F}_p^2:P=0\}$、周期点数 $a_L=\prod_{z^L=w^L=1}P\in\mathbb{Z}$（§4.2）、$P\bmod p$ 還元型、Newton 多角形、$\mu_{\min}(p)/\mu_p$——すべて $P$ から $\mathbb{Z}$ 上計算可能で、曲線の **$L$ 函数の Euler 因子**を組み立てる。一方 $\log m(P)$ は同じ $L$ 函数の**アルキメデス特殊値**。

⇒ **6-1 の成熟形**：自由エネルギー（$\infty$ の特殊値）と $p$ 進エントロピー（$p$ の特殊値）は、同一 $P$ の**一つの $L$ 函数の異なる素点での特殊値**。双対＝可解性の特徴づけ＝同じ数論的特殊性の二つの顔。

### 9.3 位置づけと限界

- **効く点**：族の特徴づけ＝スペクトル曲線の数論型の分類であり、$\Lambda$／$p$ 進側（点数・Newton・還元型）はそれを**決定可能・機械計算可能に検出・選別**する。本プロジェクト固有の強み。
- **限界**：Boyd–Deninger–Beilinson は深く高種数では大きく予想的。$\Lambda$ 側は数論型を**検出・選別**するが閉形式を**証明**する道具ではない（必要条件・診断、解法ではない）。
- **次**：(1) 既知可解模型（六頂点=種数0, 八頂点=種数1）でスペクトル曲線 $P$ の数論型と閉形式型の対応を実データで確認（点数 $N_p$・Newton から $L$ 函数局所因子、$m(P)$ の $L$ 値表示）。(2) 「可解 $\iff$ 曲線が特殊 $L$ 値 Mahler 測度」を命題として定式化し、$\Lambda$ 側プローブで候補系を選別する枠組みを作る。(3) §6 Q5（八頂点＝楕円で双対がどう変わるか）は種数1の具体例としてここに接続。
