# cycle 7 / T2: カイラル Potts の Onsager 分散を有限 N から抽出

スクリプト `dispersion_lambda.sage`、出力 `.out`（SageMath 10.6）。

## 結果（N=2, λ 記号的）

charpoly($x$) を $\mathbb{Q}(\omega)[\lambda]$ 上で因数分解:
- 1次因子（固有値）: $\lambda-1,\ \lambda+1,\ -2\lambda,\ \lambda(\times2)$。
- 2次因子2つ、判別式:
  $$\mathrm{disc}_\pm(\lambda)=9\lambda^2\mp6\lambda+9=9\bigl(1+\lambda^2-2\lambda\cdot(\pm\tfrac13)\bigr).$$

## Onsager 分散の確認

2次因子の固有値は $E=\dfrac{-b(\lambda)\pm\sqrt{\mathrm{disc}(\lambda)}}{2}=\dfrac{-(\lambda\pm1)\pm 3\sqrt{1+\lambda^2-2\lambda\cos\theta}}{2}$、
**$\cos\theta=\pm\tfrac13$**。これは超可積分カイラル Potts の **Onsager 分散** $\varepsilon(\theta)\propto\sqrt{1+\lambda^2-2\lambda\cos\theta}$ そのもの（Albertini–McCoy–Perk 型）。

- 量子化運動量 $\cos\theta_k=\pm1/3$（N=2）。準粒子エネルギー $\varepsilon=\tfrac32\sqrt{1+\lambda^2-2\lambda\cos\theta}$。
- 各準位 $E=$（λ の1次式）$\pm\varepsilon$ ＝ 自由フェルミ的（$\pm$ ペアリング）。Dolan–Grady（cycle6）と整合。

## 含意（T2: 有限 N → 極限）

- **有限 N の ℚ̄ スペクトルから Onsager 分散（$\cos\theta_k$ と √形）を直接抽出**できた。これが「有限 N＝可算決定可能 → 極限の物理（分散）」の橋。
- N が大きいと $\cos\theta_k$ は cubic 等の代数的数になり、最小多項式次数に 3,6 が出る（cycle6 の説明を確証）。極限 $N\to\infty$ で $\cos\theta_k$ が $[-1,1]$ 連続を埋め、分散 $\varepsilon(\theta)=\tfrac32\sqrt{1+\lambda^2-2\lambda\cos\theta}$（ℝ, 連続極限）になる＝ℝ脱出は一点。
- これは **既知の超可積分スペクトル（Onsager 分散）の、有限 N・可算（ℚ̄）・記号的な再導出**＝T1 Reframe 的価値も兼ねる。

## 次（cycle 8+）

- N=3,4 で $\cos\theta_k$ の集合（cubic 等）を抽出し、量子化条件（どの代数的数か）を同定。
- $\cos\theta_k$ の N 依存 → 連続分散への外挿を可算データから明示。
