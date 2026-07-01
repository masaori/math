# cycle 9 / T2: N=4 の cubic 因子（cubic 運動量の存在確認）

スクリプト `dispersion_N4_lam1.sage`、出力 `.out`（SageMath 10.6, λ=1 固定）。

## 結果

N=4 カイラル Potts (λ=1) の charpoly ℚ 因数分解: 因子次数分布 `{1:21, 2:2, 3:2, 4:7, 6:1, 8:2}`。
- **cubic(deg3) 因子 2 個**: $x^3-3x^2-3x+2$, $x^3-3x^2-3x+8$（ともに判別式 621=27·23, 非平方 → Galois S_3, 真の cubic 体）。
- ⇒ **cubic な代数的量（cubic 運動量 cosθ 候補）が N=4 で出現**（cycle6/7 の予測と整合。cycle5 の次数3,6 観測を λ=1 で再確認）。

## 正直な限界

- λ=1 固定では準位 $E=(\text{linear in }\lambda)\pm\varepsilon(\theta)$ を分離できず、cubic 因子から $\cos\theta$ を**一意に取り出せない**。
- 「cubic 因子存在 = cubic 運動量」は整合的だが、**厳密な $\cos\theta$ 同定には超可積分スペクトル理論（Albertini–McCoy–Perk の量子化条件）との照合が必要**（cycle10+）。symbolic-λ の N=4 charpoly は 81 次で計算困難。
- また N=2,3 で得た $\cos\theta=\pm1/3$ が ℤ_3 模型定数か真の運動量かも要確認（cycle10+）。

## まとめ（T2 の現状）

- 確定: 有限 N スペクトル∈ℚ̄、Onsager 分散形 $\sqrt{1+\lambda^2-2\lambda\cos\theta}$（N=2,3 で確認）、cubic 運動量の存在（N=4）。
- 未: 運動量 $\cos\theta_k$ の N 依存則・量子化条件の厳密同定。超可積分スペクトル理論との照合が次段。
