# cycle 8 / T2: N=3 の運動量 cosθ_k 抽出

スクリプト `dispersion_N3.sage`、出力 `.out`（SageMath 10.6）。

## 結果（N=3, λ 記号）

charpoly($x$) over $\mathbb{Q}(\omega)[\lambda]$ の因子次数分布: $\{1:15,\ 2:4,\ 4:1\}$。
- deg-2 因子（4個）: 判別式 $9(1+\lambda^2-2\lambda\cos\theta)$、**$\cos\theta=\pm1/3$**（N=2 と同じ）。
- deg-1 因子（15個）: λ の1次式（rational 固有値）。
- deg-4 因子（1個）: 追加の運動量を符号化（multiquadratic or quartic）。

## 観察

- **Onsager 分散 $\varepsilon\propto\sqrt{1+\lambda^2-2\lambda\cos\theta}$ は N=3 でも confirmed**。明示運動量 $\cos\theta=\pm1/3$ は N=2,3 で共通（ℤ_3 クロック構造由来らしい）。
- 量子化運動量の集合は N とともに増えるが緩やか（超可積分模型は1セクターあたり少数のフェルミオンモード）。**cubic な運動量は N≥4 で出現**（cycle5 で次数3,6 を観測）→ deg-4/高次因子に対応。
- 正直: deg-4 因子の運動量の明示抽出は未（さらなる体拡大での因数分解が要る）。本 step は「分散形と主要運動量 ±1/3 の N=3 確認」まで。

## 含意（T2: 有限 N → 連続分散）

- 有限 N の ℚ̄ スペクトルから、量子化運動量 $\cos\theta_k$（代数的）と分散形 $\sqrt{1+\lambda^2-2\lambda\cos\theta}$ が抽出できる。
- $N\to\infty$ で $\cos\theta_k$ が $[-1,1]$ を稠密化 → 連続分散 $\varepsilon(\theta)$（ℝ, 連続極限＝ℝ脱出一点）。これが「有限 N＝可算決定可能 → 極限の物理（分散）」の橋。
- 次（cycle 9+）: deg-4/高次因子の運動量抽出、N=4 の cubic 運動量の同定、$\cos\theta_k$ の N 依存則。
