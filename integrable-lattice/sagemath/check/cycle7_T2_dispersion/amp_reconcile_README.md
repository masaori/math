# cycle 10 / T2: 超可積分スペクトル公式（Albertini–McCoy–Perk）との照合

文献: Albertini–McCoy–Perk「Eigenvalue spectrum of the superintegrable chiral Potts model」(Adv. Stud. Pure Math. 19, 1–55, 1989); Albertini–McCoy–Perk–Tang「Excitation spectrum and order parameter for the integrable N-state chiral Potts model」(Nucl. Phys. B 314, 741, 1989); arXiv:0806.1268(Ising-like spectrum), cond-mat/0505698(Onsager 代数 of τ^(j)).

## 文献の要点

- 超可積分カイラル Potts のスペクトルは **Ising 的（自由フェルミオン $\sqrt{}$ 構造）**。準粒子エネルギーは $\varepsilon(\theta)\propto\sqrt{1+\lambda^2-2\lambda\cos\theta}$ 型、$\cos\theta_k$ は模型固有の量子化条件で決まる。
- Onsager 代数（Dolan–Grady）が対称性の源（cycle6 で確認済）。
- **重要な注記（AMP）**: 「準粒子形をもたない励起も存在」＝全固有値が $E=\text{base}\pm\sum_k\varepsilon(\theta_k)$ に収まるわけではない。

## 私の数値との照合（正直に）

- **整合**: cycle7-8 で得た判別式 $9(1+\lambda^2-2\lambda\cos\theta)$ ＝ AMP の Ising 的 $\sqrt{1+\lambda^2-2\lambda\cos\theta}$ 形と一致。Dolan–Grady（cycle6）とも整合。$\cos\theta=\pm1/3$（N=2,3）は分散に現れる真の代数的量。
- **未確定（$\cos\theta=\pm1/3$ の解釈）**: これが AMP の量子化運動量そのものか、n=3 模型係数 $(1-\omega^{-a})^{-1}$ 由来の定数かは、**AMP の明示的量子化多項式（論文本体, abstract では不足）との逐条照合が要る**。現時点では「Ising 的分散の√中身に現れる代数的量」までが確実。
- **高次因子の説明**: N=4 の cubic 因子（cycle9）・非2冪次数は、(a) 運動量 $\cos\theta_k$ が cubic、(b) AMP のいう「非準粒子励起」、の両方が寄与しうる。単純な $\pm\sum\varepsilon$ に収まらない部分がある（AMP と整合）。

## 結論（T2 の確定/未確定）

- **確定**: 超可積分カイラル Potts の有限 N スペクトル ∈ ℚ̄（決定可能）、**Ising 的自由フェルミ $\sqrt{1+\lambda^2-2\lambda\cos\theta}$ 構造**（AMP・Dolan–Grady と整合、有限 N 可算データから確認）。
- **未確定**: $\cos\theta_k$ の AMP 量子化運動量との厳密同定、非準粒子励起の分離。これらは AMP 論文本体の公式との逐条照合が必要（cycle11+、文献本体入手が要）。
- T2 の到達点: 「既知の Ising 的超可積分スペクトルを、有限 N の可算（ℚ̄）データから記号的に確認・再導出」。厳密な運動量辞書までは未到達（正直）。
