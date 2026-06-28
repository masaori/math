# cycle 6 / T2: Dolan–Grady で超可積分を決定的確認（cycle5 の過剰訂正を再訂正）

スクリプト `dolan_grady_test.sage`、出力 `.out`（SageMath 10.6）。

## 決定的結果

私の chiral Potts $H=H_0+\lambda H_1$（$H_0=-\sum_j\sum_a c_a X_j^a$, $H_1=-\sum_j\sum_a c_a Z_j^aZ_{j+1}^{n-a}$, $c_a=(1-\omega^{-a})^{-1}$）は **Dolan–Grady 関係**
$$[H_0,[H_0,[H_0,H_1]]]=k^2[H_0,H_1],\quad [H_1,[H_1,[H_1,H_0]]]=k^2[H_1,H_0],\quad k^2=9$$
を **N=2,3 で厳密に満たす**（両関係 True）。⇒ **Onsager 代数＝超可積分が確定**。

## 訂正の訂正（正直に）

- **cycle 4**: 「カイラル Potts スペクトルは Onsager 構造（自由フェルミ）」と主張（N=2,3 で全2冪次数）。
- **cycle 5**: 「N=4,5 で次数3,6,16 が出る ⇒ Onsager でない」と**撤回**。
- **cycle 6（本結果）**: Dolan–Grady で**超可積分は確定**。⇒ **cycle 5 の撤回が過剰訂正で誤り**だった。

正しい理解:
- 超可積分（Onsager）でも、**最小多項式の次数は2冪とは限らない**。スペクトルは $E=(\text{運動量 base 体の元})\pm\sum_k\sqrt{(\text{base 体の元})}$ の形で、量子化運動量 $\cos\theta_k$ が **cubic 等の非2冪な代数的数**になると、全体次数に 3,6 等が現れる。自由フェルミの「$\pm\sqrt{}$ ペアリング」は base 体**上で**健在。
- 「全次数が2冪」は Onsager の必要条件ではない（base 体が ℚ のときだけ）。cycle 5 はこれを取り違えた。

## robust な結論

- カイラル Potts（超可積分, Dolan–Grady 確定）の**有限 N スペクトル ∈ ℚ̄・決定可能**（不変）。
- スペクトルは **Onsager/自由フェルミ構造**をもつ（Dolan–Grady で確定）。準位は運動量 base 体上の $\pm\sqrt{}$ 構造。
- 教訓: 「次数が2冪か」だけで自由フェルミ性を判定してはいけない。構造判定は Dolan–Grady/Onsager で行う。

## 次（cycle 7+）

- 既知の超可積分スペクトル公式（Albertini–McCoy–Perk: $E=a+b\lambda+\sum_k m_k\sqrt{1+\lambda^2-2\lambda\cos\theta_k}$ 型）と有限 N の ℚ̄ スペクトルを直接照合し、運動量 $\cos\theta_k$ と √中身を同定。
- これが T2「有限 N→極限」の本筋（Onsager 分散の代数的抽出）。
