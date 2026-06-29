# cycle 7 / T3: π(p,1) の閉形（Wall 棄却後に残る rigorous 部）

スクリプト `pi_p1_closed_form.sage`、出力 `.out`（SageMath 10.6）。

## 命題（rigorous）

$T\in M_d(\mathbb{Z})$, $p\nmid\det T$ のとき、$\mathrm{Tr}\,T^N\bmod p=\sum_i\lambda_i^N$（$\lambda_i\in\overline{\mathbb{F}_p}^\times$ は $T\bmod p$ の固有値）。各 $\lambda_i^N$ は周期 $\mathrm{ord}(\lambda_i)$ で周期的だから:
$$\pi(p,1)\ \big|\ \mathrm{lcm}_i\,\mathrm{ord}(\lambda_i).$$
（$\mathrm{ord}(\lambda_i)$ は $\lambda_i\in\mathbb{F}_{p^{d_i}}$ の乗法的順序、$d_i$＝charpoly の既約因子の次数。$\mathrm{ord}(\lambda_i)\mid p^{d_i}-1$。）

## 検証

六頂点 7 種 × 素数 {3,5,7,11,13}（p∤det）, 計 **25 例すべてで π(p,1) = lcm{ord(λ_i)}（等号）**。
（rigorous には「割り切る」だが、generic に等号で、全例等号。）

## D-U2 命題 A の周期上界（決定可能・閉形）

既知の $\pi(p,k)\mid p^{k-1}\pi(p,1)$ と合わせ:
$$\boxed{\ \pi(p,k)\ \big|\ p^{k-1}\cdot\mathrm{lcm}_i\,\mathrm{ord}(\lambda_i)\ }$$
- 右辺は **charpoly($T$) mod $p$ の既約分解と各根の順序から決定可能**（$\le p^{k-1}\cdot\mathrm{lcm}(p^{d_i}-1)$）。
- ⇒ D-U2 命題 A の「$v_p(Z_N)$ の周期」に**閉じた決定可能上界**が付いた。

## Wall との関係（正直に）

- **Wall 等式 $\pi(p,k)=p^{k-1}\pi(p,1)$ は棄却済み**（cycle6, 六頂点でも 4.5% 破れ）。よって上の関係は**等号でなく「割り切る」**でのみ rigorous。
- だが上界自体（$\pi(p,k)\mid p^{k-1}\mathrm{lcm}\{ord\}$）は不変・rigorous・決定可能。これが T3 で残る確実な成果。
- $\pi(p,1)=\mathrm{lcm}\{ord\}$ は generic 等号（全25例）だが、一般の厳密証明（等号いつ）はトレースの coincidence 次第（別問題, 観察に留める）。

## まとめ（T3 トラックの確定事項）

1. D-U2 命題 A: $v_p(Z_N)$ は周期 $\pi(p,k)$ で最終周期（決定可能, cycle3）。
2. 周期上界: $\pi(p,k)\mid p^{k-1}\mathrm{lcm}_i\mathrm{ord}(\lambda_i)$（rigorous, 閉形, 決定可能, cycle7）。
3. Wall 等号は一般・可積分とも不成立（棄却, cycle6）。
