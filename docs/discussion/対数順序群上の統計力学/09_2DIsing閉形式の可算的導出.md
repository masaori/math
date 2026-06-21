# 09. 2 次元 Ising 閉形式の可算的導出（Step 1–4）

**目標**：2 次元正方格子 Ising の自由エネルギー密度（Onsager 閉形式）を、できるだけ可算・代数的な世界（$\Lambda$、$\mathbb{Z}[x]$、円分体つき $\overline{\mathbb{Q}(x)}$）で進め、$\mathbb{R}$ への移行を**最後の一箇所（連続極限）に隔離**して導く。これは [README](README.md) の「核は $\Lambda$、脱出は一気に $\mathbb{R}$」の具体例であり、[07](07_Λ帰属と可解性は別.md)（可解性は別構造から来る）の「解ける側」の中身。

記法：分数や指数はテキストで書く（$x^2$, $(1+x^2)/(2x)$ など）。

---

## Step 1：分配多項式 $Z_L(x)\in\mathbb{Z}[x]$（数え上げだけ）

**格子**：$L\times L$ 正方格子・周期境界（トーラス）。サイトを $(i,j)$、$i,j\in\mathbb{Z}/L\mathbb{Z}$ で表す。サイト数 $L^2$、辺数 $2L^2$。

**配位**：$\sigma:(i,j)\mapsto\sigma_{i,j}\in\{+1,-1\}$。総数 $2^{L^2}$（有限）。

**破れボンド数**：辺 $\{u,w\}$ が不一致（$\sigma_u\ne\sigma_w$）のとき「破れた」。$m(\sigma)$＝破れた辺の本数 $\in\{0,\dots,2L^2\}$。

**エネルギー**：$\mathcal{E}(\sigma)=-J|E|+2J\,m(\sigma)$（破れ数の一次関数。基底状態 $m=0$、準位は $2J$ 刻み＝単一量子 $\delta=2J$）。

**多重度**：$\Omega_L(m)$＝破れ数ちょうど $m$ の配位数 $\in\mathbb{N}$。総和は $2^{L^2}$。

**形式変数と分配多項式**：$x$ を不定元とし
$$
Z_L(x)=\sum_{\sigma}x^{\,m(\sigma)}=\sum_{m}\Omega_L(m)\,x^{\,m}\in\mathbb{Z}[x].
$$
物理の分配関数は $Z=e^{\beta J|E|}\,Z_L(x)\big|_{x=e^{-2\beta J}}$。全体因子 $e^{\beta J|E|}$（基底状態の重み、配位に依らない定数）は確率・転移に効かないので外す。$x=e^{-2\beta J}$ の代入（＝$\exp$）はしない。

**有限 $L$ の Massieu 自由エントロピー**：有理点 $x=q\in\mathbb{Q}_{>0}$ で $Z_L(q)\in\mathbb{Q}_{>0}$、その素因数分解の指数ベクトル $\Phi_L=\log Z_L(q)\in\Lambda$。

### 破れ数の行・列分割（Step 2 の土台）

辺を水平 $E_h$（同じ行の隣接）と垂直 $E_v$（上下の行の同列）に分ける。$E=E_h\sqcup E_v$、各 $L^2$ 本。指示関数を $\mathbf{1}[P]$（真で 1）とすると
$$
m(\sigma)=\sum_{e\in E}\mathbf{1}[\sigma_u\ne\sigma_w]=\sum_{e\in E_h}\mathbf{1}[\dots]+\sum_{e\in E_v}\mathbf{1}[\dots].
$$
行配位 $s_i=(\sigma_{i,1},\dots,\sigma_{i,L})$ を導入し、行内破れ $h(s)=\sum_j\mathbf{1}[s_j\ne s_{j+1}]$、行間破れ $v(s,s')=\sum_j\mathbf{1}[s_j\ne s'_j]$ とおくと
$$
m(\sigma)=\sum_{i=1}^{L}h(s_i)+\sum_{i=1}^{L}v(s_i,s_{i+1})\qquad(s_{L+1}=s_1).
$$

### 例：4-サイクル $C_4$
$\Omega(0)=2,\ \Omega(2)=12,\ \Omega(4)=2$ より $Z_{C_4}(x)=2+12x^2+2x^4$。$x=1/2$ で $Z=41/8=2^{-3}\cdot41$、$\Phi=\log(41/8)=\ell_{41}-3\ell_2\in\Lambda$。

---

## Step 2：転送行列 $Z_L(x)=\mathrm{Tr}\,T(x)^L$

**指示関数の陽な代数化**（$\sigma\in\{\pm1\}$ ゆえ $\mathbf{1}[\sigma_u\ne\sigma_w]=(1-\sigma_u\sigma_w)/2$）：
$$
x^{\mathbf{1}[\sigma_u\ne\sigma_w]}=\frac{1+x}{2}+\frac{1-x}{2}\,\sigma_u\sigma_w\ \in\ \mathbb{Q}[x].
$$

**転送行列**：行配位 $s,s'\in\{\pm1\}^L$ で添字付けた $2^L\times2^L$ 行列
$$
T_{s,s'}(x)=x^{\,h(s')}\,x^{\,v(s,s')}\ \in\ \mathbb{Z}[x]\quad(\text{各成分は単項式}).
$$
トーラス配位＝行配位の周期列なので
$$
Z_L(x)=\sum_{s_1,\dots,s_L}\prod_{i}T_{s_i,s_{i+1}}=\mathrm{Tr}\,T(x)^L=\sum_j\lambda_j(x)^L,
$$
$\lambda_j(x)$ は $T(x)$ の固有値。

**核心の事実**：$T(x)\in M_{2^L}(\mathbb{Z}[x])$ なので特性多項式 $\det(\lambda I-T(x))\in\mathbb{Z}[x][\lambda]$、よって**固有値は $\mathbb{Q}(x)$ 上代数的**（定義から）。

**1 次元の例**：$T=\begin{pmatrix}1&x\\x&1\end{pmatrix}$、固有値 $1\pm x$、$Z_{1D,L}=(1+x)^L+(1-x)^L$。

---

## Step 3：対角化はすべて代数的（$\mathbb{R}$ に出ない）

固有値が代数的なのは Step 2 で確定済み。Onsager–Kaufman の対角化は、その代数的固有値を**具体的に書き下す手段**であり、各部品の住処は次の通り（どれも円分体つき $\mathbb{Q}(x)$ の中、解析・実数なし）。

**方針：指数形は使わない。** 転送行列 $T(x)\in M_{2^L}(\mathbb{Z}[x])$ のまま扱い、固有値は整数係数特性多項式 $\det(\lambda I-T(x))$ の根＝代数的、で済ます。物理の標準解法の「指数形」$V_h=e^{K\sum\sigma^z\sigma^z}$, $V_v=e^{K^*\sum\sigma^x}$ は、演算子が $M^2=I$（$(\sigma^x_j)^2=(\sigma^z_j\sigma^z_{j+1})^2=I$）を満たすので $e^{aM}=\cosh a\,I+\sinh a\,M$ と**有限の代数的式に畳まれる**（無限級数・$\mathbb{R}$ ではない）。ただし $\cosh K=(1+x)/(2\sqrt x)$ 等で**不要な平方根 $\sqrt x$ を持ち込む**（1 ボンドあたり $\sqrt x$、関係 $x^{\mathbf1[\sigma\ne\sigma']}=\sqrt x\cdot e^{K\sigma\sigma'}$）。この $\sqrt x$ は全体因子に集まり最終式では有理数の対数（前因子、後述）に化けて消えるので、初めから整数形で進めばよい。

**対角化の道具の住処**（どれも円分体つき $\mathbb{Q}(x)$ の中、解析・実数なし）
- Jordan–Wigner（スピン→フェルミオン）：厳密な演算子の代数的恒等式。
- Fourier：$\theta_k=2\pi k/L$ は使わず、**1 の冪根** $\omega=e^{2\pi i/L}$（$z^L=1$ の根、円分体 $\mathbb{Q}(\omega)\subset\overline{\mathbb{Q}}$）を使う。
- Bogoliubov・対角化：$\mathbb{Q}(x,\omega)$ 上の線形代数（平方根が出ても代数的）。

**有限 $L$ では cosh・cos・sinh は解析関数でなく代数的数の別名**
- $\cos\theta_k:=(\omega^k+\omega^{-k})/2\in\mathbb{Q}(\omega)$（実代数的数）。例：$L=5$ で $\cos(2\pi/5)=(\sqrt5-1)/4$。
- $\cosh 2K:=(1+x^2)/(2x)$、$\sinh 2K:=(1-x^2)/(2x)\in\mathbb{Q}(x)$。
- **分散関係**：$\cosh\gamma(\theta_k):=(1+x^2)^2/(2x(1-x^2))-\cos\theta_k\in\mathbb{Q}(x,\omega)$（左辺はこの右辺の代数的数を指す名前。解析的 cosh を施しているのではない）。
- 各モードの固有値因子 $\rho_k$（記号で $e^{\gamma_k}$）：二次方程式 $z^2-2\cosh\gamma(\theta_k)\,z+1=0$ の根＝代数的。

**結論**：最大固有値 $\lambda_{\max}(x)$ はモードごとの代数的因子の積で、$\overline{\mathbb{Q}(x)}$ に住む。**Step 3 はここまで完全に代数的・可算。** arccosh も $\exp$ も実数の角 $\theta$ も使わない。

---

## Step 4：唯一の $\mathbb{R}$ 脱出（連続極限）

**最大固有値が支配**：行数を増やすと $Z_L\approx\lambda_{\max}^L$、$\frac1{L^2}\log Z_L\approx\frac1L\log\lambda_{\max}$。Step 3 より
$$
\frac1L\log\lambda_{\max}=\frac12\log(2\sinh2K)+\frac1{2L}\sum_k\gamma(\theta_k).
$$

**脱出 (1)：モード和の対数（arccosh）**。$\log\lambda_{\max}$ を分けると、前因子 $\tfrac{L}2\log(2\sinh2K)$（有理数の対数＝$\Lambda_\mathbb{Q}$、可算）と、モード和 $\tfrac12\sum_k\gamma_k$（$\gamma_k=\log(e^{\gamma_k})$＝代数的数の対数で**有理数の対数でないので $\Lambda$ の外**、Baker 圏の実数）に分かれる。**$\mathbb{R}$ なのはモード和の方だけ**。有限 $L$ の厳密値 $\log Z_L(q)\in\Lambda$ は $\mathbb{R}$ を使わないが、固有値表示で近似 $\log Z_L\approx L\log\lambda_{\max}$ を使い、そのモード和を取る所で $\mathbb{R}$ に出る。

**脱出 (2)：Riemann 和 → 積分**。$\theta_k=2\pi k/L$ は $[0,2\pi)$ の $L$ 等分点、間隔 $\Delta\theta=2\pi/L$。$\frac1L\sum_k\gamma(\theta_k)=\frac1{2\pi}\sum_k\gamma(\theta_k)\Delta\theta$ は Riemann 和で、$L\to\infty$ で
$$
\frac1L\sum_k\gamma(\theta_k)\ \to\ \frac1{2\pi}\int_{-\pi}^{\pi}\gamma(\theta)\,d\theta.
$$
ここで $\theta$ が連続変数になり、解析的 $\cos\theta$ と $\gamma(\theta)=\mathrm{arccosh}(\dots)$ が初めて要る。

**閉形式（Onsager）**：
$$
-\beta f=\frac12\log(2\sinh2K)+\frac1{4\pi}\int_{-\pi}^{\pi}\gamma(\theta)\,d\theta,
$$
ここで前因子 $\tfrac12\log(2\sinh2K)=\tfrac12\log\bigl((1-x^2)/x\bigr)=\tfrac12[\log(1-x^2)-\log x]$ は、有理点 $x=q$ で**有理数の対数＝$\Lambda_\mathbb{Q}$（可算・厳密、$\mathbb{R}$ 不要）**。指数形で出た $\sqrt x$ はこの前因子に吸収され痕跡を残さない。**$\mathbb{R}$ は積分項だけ**。あるいは恒等式で二角の対称形にして
$$
-\beta f=\log2+\frac1{8\pi^2}\int_0^{2\pi}\!\!\int_0^{2\pi}\log\!\bigl[\cosh^2 2K-\sinh2K(\cos\theta_1+\cos\theta_2)\bigr]d\theta_1d\theta_2.
$$

**相転移の在処**：被積分関数の角括弧が $0$ に触れると $\log$ が発散し非解析。$\theta_1=\theta_2=0$ で
$$
\cosh^2 2K=2\sinh2K\iff(\sinh2K-1)^2=0\iff\sinh2K=1\iff x_c=\sqrt2-1.
$$
これは分散の隙間が閉じる点（Step 3）＝ KW 自己双対点（[08](08_KW双対性_補足.md)）。**臨界点の位置 $x_c=\sqrt2-1$ は代数的（可算）に決まり、非解析性そのもの（積分の特異性）は $\mathbb{R}$。**

---

## 帰属の台帳（どこに住むか）

- $\Omega_L(m)$：$\mathbb{N}$（数え上げ）
- $Z_L(x)$：$\mathbb{Z}[x]$（整係数多項式）
- $\Phi_L=\log Z_L(q)$（$q\in\mathbb{Q}_{>0}$）：$\Lambda$（素因数分解の指数ベクトル、厳密）
- 転送行列 $T(x)$：$M_{2^L}(\mathbb{Z}[x])$
- 固有値 $\lambda_j(x)$・分散 $\cosh\gamma(\theta_k)$・$\cos\theta_k$：$\overline{\mathbb{Q}(x)}$（円分体つき、代数的）
- 前因子 $\tfrac12\log((1-x^2)/x)$（有理点）：$\Lambda_\mathbb{Q}$（可算・厳密）
- モード和 $\tfrac12\sum_k\gamma_k$／積分 $\int\gamma(\theta)d\theta$：$\mathbb{R}$（代数的数の対数 arccosh ＋ 連続極限）
- 臨界点 $x_c=\sqrt2-1$：$\overline{\mathbb{Q}}$（代数的）
- 自由エネルギーの非解析性：$\mathbb{R}$

**一言**：Step 1–3（有限格子の数え上げ・転送行列・対角化）は整数・代数的・可算で閉じる（指数形は使わず $T(x)\in M(\mathbb{Z}[x])$ のまま）。最終式 $-\beta f$ は **可算な前因子 $\Lambda_\mathbb{Q}$ ＋ $\mathbb{R}$ の積分項**に綺麗に分かれ、$\mathbb{R}$ は積分（arccosh ＋ Riemann 和→積分）だけ。閉形式と相転移はそこに宿り、臨界点の位置だけは代数的に残る。

---

## 他ノートとの関係

- [05](05_相転移はΦで論じられるか.md)：相転移の足跡（Fisher 零点・凸性）。本ノートは「閉形式が取れる場合」の具体。
- [06](06_文献調査_Ising臨界指数.md)：零点プログラムとの対応。
- [07](07_Λ帰属と可解性は別.md)：可解性（極限の閉形式）は別構造から来る。2D Ising は自由フェルミオン構造ゆえ Step 3 が閉じる、がその中身。
- [08](08_KW双対性_補足.md)：臨界点 $x_c=\sqrt2-1$ は KW 自己双対点と一致。
