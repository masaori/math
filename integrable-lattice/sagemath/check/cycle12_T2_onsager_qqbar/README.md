# cycle 12 / T2→T1 統合: 2D Ising Onsager 解の有限 N 構造を Λ/ℚ̄ で Reframe

## 0. この成果物の位置づけ（最初に読むこと）

- **Onsager 解自体は既知**である。文献: L. Onsager, *Crystal Statistics I*, Phys. Rev. **65** (1944) 117（自由エネルギー閉形式・臨界点）; B. Kaufman, *Crystal Statistics II*, Phys. Rev. **76** (1949) 1232（有限 L のスピノル解＝転送行列の全固有値の閉形式）; H. A. Kramers & G. H. Wannier, Phys. Rev. **60** (1941) 252（双対性と臨界点 $x_c=\sqrt2-1$ の決定）。
- **本 step の寄与は「既知結果の可算・厳密・形式検証可能な書き換え（Reframe）」であり、新しい厳密解ではない。** 新しい熱力学極限・新しい閉形式・新しい相関関数は一切主張しない。
- これは cycle 11 総括の方針判断（T2「未解決模型の実厳密解」は 11 cycle を通して新厳密解を産まず T1 と重複 → **既定方針 1: T2 を T1 に統合**）の実行である。
- **数値一致は証明ではない。** 本ディレクトリの主張のうち「厳密」と書いたものは、すべて $\mathbb{Z}[x]$ / $\mathbb{Q}(x)$ / 円分体 $K(x)$ / `QQbar` / `AA` 上の**記号的な等号**である。数値は 05 の (F) にのみ現れ、そこには「証明ではない」と明記している。
- **有限 $L$ の決定可能性は極限の可解性を含意しない。** 四軸（`inputs/seeds/lambda-statement-program.md`）の 1・2（帰属・計算可能性）と 4（可解性）は独立であり、本 step が示したのは 1・2（＋3 の一部）だけである。極限が閉形式をもつこと（＝ Onsager の内容）は既知文献に依拠しており、本ディレクトリでは証明していない。

対応する理論ノート: リポジトリ root の `docs/discussion/対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md`（Step 1–4）と `08_KW双対性_補足.md`。本ディレクトリは 09 の Step 1–3 を SageMath で厳密に実証し、Step 4（$\mathbb{R}$ 脱出）が一点に隔離されることを示す。

## 1. 対象

$L\times L$ 正方格子・周期境界（トーラス）の 2 次元 Ising 模型。破れボンド数 $m(\sigma)$、形式変数 $x$（物理では $x=e^{-2\beta J}$、ただし**代入はしない**）。

- 分配多項式 $Z_L(x)=\sum_\sigma x^{m(\sigma)}\in\mathbb{Z}[x]$
- 転送行列 $T(x)\in M_{2^L}(\mathbb{Z}[x])$、$T_{s,s'}(x)=x^{h(s')+v(s,s')}$
- $C(x)=(1+x^2)^2/\bigl(2x(1-x^2)\bigr)$（Onsager 分散の主要部、$\cosh 2K\coth 2K$ の代数的別名）
- $\cosh\gamma(\theta)=C(x)-\cos\theta$、$\rho(\theta)$ は $z^2-2\cosh\gamma(\theta)z+1=0$ の根（記号で $e^{\gamma(\theta)}$）
- $\cos\theta_k=(\zeta_{2L}^{e}+\zeta_{2L}^{-e})/2$（**円分体 $\mathbb{Q}(\zeta_{2L})$ の元**。実数の角も三角関数も使わない）
- 前因子 $P=(x(1-x^2))^{L/2}$

## 2. 手順と結論（スクリプト別）

各スクリプトは `sage <name>.sage` で実行でき、実行ログは同名の `.out`（SageMath 10.6, 2026-07-26 実行）。

### 01_transfer_matrix_ZZx.sage — Step 1–2: $\mathbb{Z}[x]$ で閉じること

| 確認項目 | 結果 |
|---|---|
| $T(x)$ の全成分が $\mathbb{Z}[x]$ の**単項式** $x^k$（$L=2,3,4$） | True |
| $\operatorname{Tr}T(x)^L=Z_L(x)$（$Z_L$ は全 $2^{L^2}$ 配位を辺ごとに直接列挙した独立計算） | True |
| $Z_L(1)=2^{L^2}$ | True |
| $\det(\lambda I-T(x))$ の係数が全て $\mathbb{Z}[x]$ | True |

$L=2$: $Z_2=2x^8+12x^4+2$。$L=4$: 15 項、$\sum$ 係数 $=65536$。
$\mathbb{Q}(x)[\lambda]$ 上の charpoly 因数分解は $L=2,3$ で**1 次と 2 次の因子のみ**（自由フェルミオン構造の最初の痕跡）。

⇒ **09 Step 1–2 は $\mathbb{Z}[x]$ で完全に閉じる**（$\mathbb{R}$ も $\exp$ も不要）。固有値が $\mathbb{Q}(x)$ 上代数的であることは、charpoly $\in\mathbb{Z}[x][\lambda]$ から定義的に従う。

### 02_qqbar_spectrum.sage — Step 3: 有理点でのスペクトルの $\overline{\mathbb{Q}}$ 帰属

有理点 $q\in\{1/2,\ 1/3,\ 2/5\}$、$L=2,3,4$ の全ケースで:

| 確認項目 | 結果 |
|---|---|
| 全固有値 $\in$ `QQbar` | True |
| 全固有値が実 | True |
| 全固有値が正 | True |
| 最小多項式の次数が**すべて 2 冪**（$L=2,3$ で $\{1,2\}$、$L=4$ で $\{1,2,4\}$） | True |

witness として各ケースの $\lambda_{\max}$ の最小多項式（既約）を出力（例: $q=1/2,L=4$ で $\lambda^4-\frac{553}{256}\lambda^3+\frac{5949}{8192}\lambda^2-\frac{44793}{1048576}\lambda+\frac{6561}{16777216}$）。

⇒ **有限 $L$・有理 $x$ では対角化が $\overline{\mathbb{Q}}$ で閉じ、証明書（最小多項式）付きで決定可能。** 次数が 2 冪であることは多重 2 次拡大＝自由フェルミオン構造の指標（cycle 4–6 で観察した「2 冪次数」と同じ現象。ただし cycle 6 の教訓どおり、次数だけで自由フェルミオン性を断定はしない）。

### 03_onsager_dispersion_identity.sage — Onsager 分散関係を有理関数の恒等式として

**本ディレクトリの中心。$\mathbb{R}$ も解析関数も一切使わずに、Onsager 分散関係を記号的な等号として確認する。**

| 確認項目 | 結果 |
|---|---|
| (a) $\det T(x)=(x(1-x^2))^{L\cdot 2^{L-1}}$（$L=2,3,4$） | True |
| (b) $cp(P^2/\lambda)\cdot\lambda^{2^L}=P^{2^L}\cdot cp(\lambda)$（$L=2,4$、$P=(x(1-x^2))^{L/2}$） | True |
| (c) 各 2 次因子の**2 根の比**が $e^{n\gamma(\theta)}$（$\Leftrightarrow W:=A^2/(2B)-1=T_n(C(x)-\cos\theta)$、$T_n$ は Chebyshev） | True |
| (d) $L=4$ の 4 次因子が 2 モードの対称式 $P\rho(\theta_a)^{\pm1}\rho(\theta_b)^{\pm1}$ と一致 | True |

- (a) は Kaufman の前因子 $(x(1-x^2))^{L/2}$ の大域的 witness。
- (b) は $\pm\gamma$ ペアリング（自由フェルミオンの粒子・空孔対称性）＝固有値集合が $\lambda\mapsto P^2/\lambda$ で閉じること。$\mathbb{Z}[x][\lambda]$ の恒等式。
- (c) の一致内訳（$K=\mathbb{Q}(\zeta_{2L})$ 上で charpoly を因数分解して得た 2 次因子）:
  - $L=2$: $\cos\theta=0$（NS）で $n=2$
  - $L=3$: $\cos\theta=1/2$（NS）と $\cos\theta=-1/2$（R）でそれぞれ $n=2$
  - $L=4$: $\cos\theta=0$（R）の 2 因子で $n=2$
  $n=2$ が出るのは、$\cos\theta$ が縮退している 2 モードが同時に符号反転するため（比が $\rho^2$）。
- (d) $L=4$ の 4 次因子は NS セクターの $\cos\theta_a=(\zeta_8^3-\zeta_8)/2=\sqrt2/2$, $\cos\theta_b=-\sqrt2/2$ の 2 モードで、
  $e_1=4PC_aC_b,\ e_2=P^2(2T_2(C_a)+2T_2(C_b)+2),\ e_3=P^2e_1,\ e_4=P^4$ と**厳密一致**。

⇒ **「分散関係 $\cosh\gamma(\theta)=C(x)-\cos\theta$」は、円分体つき $\overline{\mathbb{Q}(x)}$ における多項式・有理関数の恒等式として厳密に検証できる。** arccosh も exp も実数の角 $\theta$ も使っていない（09 Step 3 の主張の実証）。

### 04_kaufman_multiset_AA.sage — Kaufman 閉形式による全スペクトルの再構成

$\lambda=(q(1-q^2))^{L/2}\prod_k\rho(\theta_k)^{s_k/2}$（$s_k=\pm1$）から $2^L$ 個の候補を作り、実スペクトルと `AA`（実代数的数）上で**厳密に**多重集合比較する。**パリティ規約は仮定せず、NS 偶/奇 × R 偶/奇 の 4 通りを全部試して、一致するものを計算で決める。**

| $q$ | $L$ | 一致したパリティ規約 |
|---|---|---|
| 1/2（高温側 $q>x_c$） | 2, 3 | NS 偶 / R **奇** |
| 1/3（低温側 $q<x_c$） | 2, 3 | NS 偶 / R **偶** |

いずれも 4 通り中ちょうど 1 通りだけが厳密一致（他 3 通りは False）。

**観察（正直に記す）**: $\rho$ の分岐を常に $\rho\ge1$ に取ると、**R セクターのパリティが高温側と低温側で入れ替わる**。これは Kaufman 解で知られる「$T<T_c$ では $\gamma(\theta=0)$ の符号を反転させる」規約の問題と同じもので、本スクリプトはそれを**仮定せず計算で決定**している。なお $q=1/2$ と $q=1/3$ は KW 双対の対（05 (B) 参照）であり、$C(x)$ は両者で同値だが分岐規約が異なる。

**計算量の限界（隠さず記録）**: `AA` の入れ子平方根の厳密比較は $L$ とともに急激に重くなり、**$L=4$ は 10 分以上でも終わらなかったので実行していない**。$L=4$ に相当する厳密確認は 03 の (c)(d)（有理関数・円分体上の恒等式）で別経路により実施済み。

### 05_critical_point_and_R_escape.sage — 臨界点の代数性・Λ 帰属・$\mathbb{R}$ 脱出の隔離

| 確認項目 | 結果 |
|---|---|
| (A) ギャップ閉塞条件 $\cosh\gamma(0)=1$ $\Leftrightarrow$ $(1+x^2)^2-4x(1-x^2)=(x^2+2x-1)^2=0$ | True（$\mathbb{Z}[x]$ の恒等式） |
| (A) $x_c=\sqrt2-1$ の最小多項式 $=x^2+2x-1$（2 次）、$x_c\in\overline{\mathbb{Q}}$ | True |
| (B) KW 双対 $x\mapsto(1-x)/(1+x)$ の固定点条件も $x^2+2x-1=0$ | True |
| (B) $C\bigl((1-x)/(1+x)\bigr)=C(x)$（分散関数の KW 双対不変性） | True（$\mathbb{Q}(x)$ の恒等式） |
| (C) $C(x)-2=(x^2+2x-1)^2/(2x(1-x^2))$、有理点 $q\ne x_c$ でギャップ $>0$ | True（$q=1/2,1/3$ で $1/12$、$q=2/5$ で $1/420$） |
| (D) $\Phi_L=\log Z_L(1/2)\in\Lambda$（$L=2..6$、素因数分解の指数ベクトル） | 出力（例 $L=4$: $2^{-31}\cdot2897\cdot8284849$） |
| (E) 前因子 $(1/2)\log((1-x^2)/x)$ は有理点で $\Lambda_\mathbb{Q}$ | True（$q=1/2$ で $3/2$、$q=1/3$ で $8/3$） |
| (E) モード和の $\log\rho(\theta)\notin\Lambda_\mathbb{Q}$ | True（下記の論証） |

(E) の $\Lambda_\mathbb{Q}$ 非帰属の論証（数値でなく論理）: $\log\rho\in\Lambda_\mathbb{Q}\Leftrightarrow\exists n\ge1:\rho^n\in\mathbb{Q}_{>0}$。$\rho$ の最小多項式は 2 次で定数項 $1$ なので共役は $1/\rho$。$\rho^n=r\in\mathbb{Q}$ なら共役を取って $(1/\rho)^n=r$、よって $\rho^{2n}=1$ となり $\rho>1$ に矛盾。したがって任意の $n$ で $\rho^n\notin\mathbb{Q}$、すなわち $\log\rho\notin\Lambda_\mathbb{Q}$。（$q=1/2,L=3$ で $\rho$ の最小多項式は $z^2-\frac{19}{6}z+1$ と $z^2-\frac{31}{6}z+1$。）

(F) 既知 Onsager 閉形式との突き合わせ（**数値。証明ではない**）: $x=1/2$ で閉形式 $-\beta f=0.827026956718329$ に対し、有限 $L$ の厳密値からの推定 $(1/L^2)\log Z_L(1/2)-\log(1/2)$ は $L=2$ で差 $0.1197$、$L=8$ で差 $0.00109$。**これは数値的整合の確認にすぎず、極限の存在も一致も証明していない。**

## 3. 帰属台帳（09 の台帳を本ディレクトリの検証結果で埋めたもの）

| 量 | 帰属 | 本ディレクトリでの厳密確認 |
|---|---|---|
| 多重度 $\Omega_L(m)$ | $\mathbb{N}$ | 01（全配位列挙） |
| $Z_L(x)$ | $\mathbb{Z}[x]$ | 01 |
| $\Phi_L=\log Z_L(q)$, $q\in\mathbb{Q}_{>0}$ | $\Lambda$ | 05 (D) |
| $T(x)$ | $M_{2^L}(\mathbb{Z}[x])$ | 01 |
| 固有値 $\lambda_j(x)$ | $\overline{\mathbb{Q}(x)}$（有理点で $\overline{\mathbb{Q}}$、最小多項式 witness） | 01, 02 |
| $\cos\theta_k$ | $\mathbb{Q}(\zeta_{2L})$ | 03 |
| 分散 $\cosh\gamma(\theta)$, $\rho(\theta)$ | $\overline{\mathbb{Q}(x)}$ | 03 (c)(d), 04 |
| 前因子 $(x(1-x^2))^{L/2}$ | $\mathbb{Q}(x)$（有理点で $\Lambda_\mathbb{Q}$） | 03 (a), 05 (E) |
| 臨界点 $x_c=\sqrt2-1$ | $\overline{\mathbb{Q}}$（2 次） | 05 (A)(B) |
| モード和 $\sum_k\gamma(\theta_k)$・積分 $\int\gamma(\theta)d\theta$ | $\mathbb{R}$（$\Lambda_\mathbb{Q}$ の外） | 05 (E) |
| 自由エネルギーの非解析性 | $\mathbb{R}$ | 未検証（既知文献に依拠） |

**$\mathbb{R}$ 脱出は 2 箇所に隔離される**: (1) モード和 $\sum_k\log\rho(\theta_k)$（代数的数の対数）、(2) 連続極限 $(1/L)\sum_k\gamma(\theta_k)\to(1/2\pi)\int\gamma(\theta)d\theta$（Riemann 和 → 積分）。有限 $L$ の $Z_L(q)\in\mathbb{Q}$、$\Phi_L\in\Lambda$、固有値 $\in\overline{\mathbb{Q}}$ はいずれも $\mathbb{R}$ を使わない。

## 4. 既知の Onsager 解との関係（何が既知で何が本 step の寄与か）

| 事項 | 出典 | 本 step の扱い |
|---|---|---|
| 自由エネルギー閉形式 $-\beta f=\frac12\log(2\sinh2K)+\frac1{4\pi}\int_{-\pi}^{\pi}\gamma(\theta)d\theta$ | Onsager 1944 | **既知として引用**。05 (F) で数値的に突き合わせただけ（証明していない） |
| 臨界点 $x_c=\sqrt2-1$ | Kramers–Wannier 1941 / Onsager 1944 | **既知**。本 step は「$x_c$ が $\mathbb{Z}[x]$ の恒等式 $(x^2+2x-1)^2$ から代数的に決まる」ことを厳密確認（05 A/B） |
| 有限 $L$ の全固有値の閉形式（スピノル解） | Kaufman 1949 | **既知**。本 step は $\mathbb{R}$・解析関数を使わない形（円分体＋2 次方程式）で組み直し、実スペクトルとの厳密一致を検証（03, 04） |
| 分散関係 $\cosh\gamma=\cosh2K\coth2K-\cos\theta$ | Onsager 1944 / Kaufman 1949 | **既知**。本 step は $\mathbb{Q}(\zeta_{2L})(x)$ の有理関数恒等式として厳密確認（03 c/d） |
| パリティ（セクター）規約と $\gamma(0)$ の符号 | Kaufman 1949 ほか | 既知の微妙な点。本 step は**仮定せず計算で決定**し、高温側と低温側で R セクターのパリティが入れ替わることを記録（04） |

**本 step が新たに主張すること**: 上記の既知内容が、$\mathbb{Z}[x]$・$\mathbb{Q}(\zeta_{2L})(x)$・`QQbar`/`AA` 上の**記号的な等号として機械検証可能**であり、$\mathbb{R}$ の使用が上記 2 点に隔離できること。**新しい厳密解は含まない。**

## 5. 未達・限界（正直な記録）

- 04 の全スペクトル再構成は `AA` の計算量により $L\le3$ のみ。$L=4$ は未実行（03 で別経路の厳密確認あり）。$L\ge5$ はどちらの経路も未実施。
- 03 の $K(x)$ 上の因数分解は $L=4$ で約 47 秒（`.out` の記録値）。$L\ge5$ は未実施（計算量の見積もりは出さない）。
- 熱力学極限の存在・Onsager 閉形式そのものは**本ディレクトリでは証明していない**（既知文献に依拠）。05 (F) は数値的整合の確認にとどまる。
- 相転移（自由エネルギーの非解析性）は $\mathbb{R}$ 側の事実であり、本ディレクトリの可算的検証の対象外。可算側に残るのは臨界点の位置 $x_c\in\overline{\mathbb{Q}}$ だけ。
- Lean 等による形式検証は未実施（integrable-lattice に `lean/` は無い）。ただし 01・03・05 (A)(B)(C) の主張はいずれも多項式恒等式なので、原理的には `decide`／reflection に乗る形である。

## 6. 実行環境

SageMath 10.6（`sage <script>.sage`）。実行日 2026-07-26。各 `.out` が実行ログ。
