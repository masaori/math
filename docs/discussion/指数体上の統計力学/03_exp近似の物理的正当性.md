# 03. 数表 $w$ を exp 近似してよい物理的正当性

**問い**：数表 $w(\varepsilon)$ を $\exp$ で近似してしまっていい物理的な正当性は何か。

物理的正当性は一つではなく、状況で根拠が違う。所属を併記しつつ、強い順に。

## 0. 何を正当化したいか

厳密重み $w(\varepsilon)=\Omega_B(U-\varepsilon)/\Omega_B(U)\in\mathbb{Q}$ を $\widetilde w(\varepsilon)=\exp_\mathbb{R}(-\beta\varepsilon)\in\mathbb{R}$ で置く。$\log_E$ を取れば、主張は

$$
f(\varepsilon)=S_B(U-\varepsilon)-S_B(U)\ \approx\ -\beta\varepsilon
$$

すなわち **$S_B$ が帯域でアフィン**（一次）。誤差 $r(\varepsilon)=f(\varepsilon)+\beta\varepsilon\in E$。正当化＝「効く $\varepsilon$ の範囲で $r$ が無視できる」根拠を与えること。

## 1. 一次の根拠：$\varepsilon\ll U$（テイラー的・最弱だが普遍）

$\varepsilon=n\delta$ で望遠鏡和

$$
f(\varepsilon)=-\sum_{k=0}^{n-1}\beta_B(k\delta)\,\delta\in E,\qquad \beta_B(V)=\frac{S_B(U-V+\delta)-S_B(U-V)}{\delta}\in E.
$$

$\beta_B$ は $V$ の単調関数（凹性より）。注目系が熱浴から引き出すエネルギー $\varepsilon$ が $U$ に比べ小さければ、和の各 $\beta_B(k\delta)$ は $\beta_B(0)=\beta$ からほとんど動かず、$f\approx-\beta\varepsilon$。誤差は二階差分のオーダー：

$$
r(\varepsilon)\sim\tfrac12\,\beta_B'\,\varepsilon^2,\qquad \beta_B'=\frac{\partial\beta_B}{\partial V}\Big|_0\in E.
$$

**正当性の中身：$|\beta_B'\varepsilon^2|\ll|\beta\varepsilon|$、つまり $\varepsilon\ll|\beta/\beta_B'|$。** これは単に「割線をその場の接線で代用してよい」だけで、$B$ が大きい必要すらない。ただし帯域が狭いときしか効かない局所近似。

## 2. 主因：熱浴の巨大性 → $\beta_B'\to0$（最強・本命）

$\beta_B'$ は熱浴の熱容量の逆数に比例する。$B$ が自由度 $N_B$ を持つ示量系なら

$$
\beta_B(V)=\beta-\frac{V}{C}+O(V^2),\qquad C\sim N_B\ (\text{熱容量、示量}).
$$

よって $\beta_B'\sim 1/C\sim 1/N_B$。注目系 $A$ は固定サイズなので $\varepsilon=O(1)$（$N_B$ に無関係）。すると

$$
r(\varepsilon)\sim\frac{\varepsilon^2}{2C}\sim\frac{\varepsilon^2}{2N_B}\ \xrightarrow{N_B\to\infty}\ 0.
$$

**正当性の中身：熱浴が大きいほど、$A$ がエネルギーを吸っても $B$ の温度が動かない（$\beta_B$ が定数化する）。** これが「熱浴」の定義そのもの。$\varepsilon$ が $U$ に対し小さい（§1）を超えて、$\beta_B$ の**変動が消える**ことを保証するのがこの極限。誤差は $1/N_B$ で系統的に小さくなり、$N_B\to\infty$ で厳密。指数形は近似でなく $N_B\to\infty$ の**像**になる。

## 3. なぜ一次が指数になるか（アフィン → 準同型）

§1・§2 が言うのは $f$ が**一次**ということだけ。一次関数 $f(\varepsilon)=-\beta\varepsilon$ は加法を保つ：$f(\varepsilon_1+\varepsilon_2)=f(\varepsilon_1)+f(\varepsilon_2)$。これを重み $w=\exp_\mathbb{R}\circ f$ に移すと

$$
w(\varepsilon_1+\varepsilon_2)=w(\varepsilon_1)\,w(\varepsilon_2),
$$

すなわち $(G,+)\to(\mathbb{R}_{>0},\times)$ の群準同型。**$S_B$ の一次性が、重みの乗法性＝指数形を強制する。** 指数は「アフィンなエントロピー差を重みに直すと自動的に出る唯一の形」（連続準同型の一意性）であって、別途持ち込む仮定ではない。物理的にはこれが**エネルギー相加性の帰結**：$A$ の二部分の重みが積になるのは、それらのエネルギーが熱浴の同じ線形応答を別々に受けるから。

## 4. 実効的に効く範囲だけでよい（ガウス的局在）

厳密分布の下で $\varepsilon$ は平均 $\langle\varepsilon\rangle$ のまわりに幅 $\sqrt{\mathrm{Var}}\sim\sqrt{C}\sim\sqrt{N_B}$ で集中するが、$A$ が固定サイズなら $A$ 側の $\varepsilon$ レンジは $O(1)$。アフィン近似が要るのは**確率が乗っている $\varepsilon$ の範囲だけ**で、そこで $r$ が小さければ全体として正当。テールでアフィンが破れても、そこに確率がなければ分配関数・平均に効かない。**正当性の中身：近似誤差を「実際に重みのかかる窓」でだけ評価すればよい。**

## まとめ（物理的正当性の階層）

| 根拠 | 条件 | 誤差 | 強さ |
|---|---|---|---|
| 接線代用 | $\varepsilon\ll|\beta/\beta_B'|$ | $\sim\beta_B'\varepsilon^2$ | 局所・普遍 |
| **熱浴巨大** | $N_B\to\infty$、$\beta_B'\sim1/N_B$ | $\sim\varepsilon^2/N_B\to0$ | **本命・系統的** |
| 相加性 | $f$ 一次 ⇒ $w$ 乗法的 | — | 指数形を強制 |
| 局在 | 確率窓 $O(1)$ | 窓外無視 | 範囲限定 |

一文で：**指数化が正当なのは、熱浴が大きく（$N_B\to\infty$）その温度が $A$ のエネルギー授受で動かないから（$\beta_B'\sim1/N_B\to0$）、エントロピー差 $f$ が帯域でアフィンになり、アフィン差は相加性ゆえ乗法的重み＝指数に一意に化けるから。** 誤差は熱浴サイズの逆数で系統的に消え、$N_B\to\infty$ で指数形は近似でなく厳密な極限像になる ── ただしその極限値 $\exp_\mathbb{R}(-\beta\varepsilon)$ は $E$ の外（$\mathbb{R}$）。

---

## メモ：この階層の中の $E$／$\mathbb{R}$ 境界

- §1〜§2 の誤差評価（$r(\varepsilon)$、$\beta_B'$、$\beta_B(V)=\beta-V/C+\dots$ の係数）はすべて $E$ 内の量で書ける。
- $\beta_B'$ や $C$ を「微分・熱容量」として連続量で書いた瞬間、§1 の二階差分・$O(\varepsilon^2)$ 展開は $\mathbb{R}$ 上の解析に乗る。$E$ 内に留めるなら二階差分商として書く。
- $N_B\to\infty$ の極限と $\exp_\mathbb{R}$ 評価は $\mathbb{R}$（[01](01_β定数化はEを出るか.md) の (a)(b) と整合）。
