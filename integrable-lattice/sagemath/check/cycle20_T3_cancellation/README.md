# cycle 20 / T3 Pure: 打ち消し（cycle 19 定理 J4 の $|J(r)|\ge2$）の検証

対応する証明本体: [`outputs/reports/cycle20_T3_cancellation_recursion.md`](../../../outputs/reports/cycle20_T3_cancellation_recursion.md)

## 何を確かめるのか

cycle 19 step 1（`cycle19_T3_theta_ge_ell_plus_1.md`）§7.1 は、ファイバー Newton 公式（定理 J4）が
$\mathrm{argmin}$ の一意性を失う（$|J(r)|\ge2$）とき消滅深度 $\theta$ を決めない、という障害を
反例つきで残した。本検証はその障害が**別の分解を取れば構造的に消える**ことを確かめる。

中心となるのは 2 つの道具である。

- **定理 L1（桁枝再帰）**: $\overline{\Phi_{(a,b)}}=\sum_\gamma\mu_\gamma(1+x)^\gamma$ を
  指数 $\gamma$ の $\ell$ 進**第 0 桁**で枝分けすると
  $\overline{\Phi}=\sum_{c=0}^{\ell-1}(1+x)^c g_c(x^\ell)$ となり、
  $\theta=\ell\cdot\min_c\mathrm{ord}\,g_c+s^*$、
  $s^*=\min\{s:\sum_{c\in C}\lambda_c\binom cs\neq0\}\le\ell-1$。
  $\binom cs$（$0\le c,s<\ell$）の行列が $\mathbb{F}_\ell$ 上で下三角単位行列なので $s^*$ は必ず存在し、
  **打ち消しは起こりえない**。
- **定理 L4（終結式公式）**: $\hat\theta_M(a,b)=v_\ell\bigl(\mathrm{Res}_x(\Psi_M,\Phi_{(a,b)})\bigr)$、
  $\Psi_M(x)=\Phi_{\ell^M}(1+x)$。整数ひとつの $\ell$ 進付値なので、
  定理 B′ が置いていた「最小点が一意」という仮定が要らない。

## ファイルと Step

| ファイル | 内容 |
|---|---|
| `_defs20.sage` | 共有定義（`theta_lc_L1` / `hat_theta_resultant` / `Theta_level_exact` / `predicted_ord_K_exact` / `L3_bound`） |
| `cancellation.sage` | Step A–D・F・G |
| `theorem_k_prime.sage` | Step E（母集団での定理 K′ 照合。長時間なので分けてある） |

- **Step A**: 定理 L1 の基礎照合。(i) cycle 19 §7.1 の反例（$\ell=2$ トーラス、$P_0=(1{:}1)$、$r=1$、
  $J(1)=\{1,2\}$、$\Lambda(1)=4$ に対し真値 $\theta(1,3)=6$）で L1 が真値を出すこと。
  (ii) 母集団 430 個 $\times\ \ell\in\{2,3,5,7\}\times\mathbb{P}^1(\mathbb{Z}/\ell^M)$ の**全列挙**で
  L1 = 直接計算（$\overline{\Phi}$ の位数）。
- **Step B**: cycle 19 §7.1 の奇素数の表（$\ell=3$ 2 例・$\ell=5$ 1 例）を再計算し、
  $|J(r)|\ge2$ だった層で L1 が $\theta$ を決めることを**件数の内訳つき**で示す。
- **Step C**: 系 L2（$\theta\le\ell^{\mathrm{sep}}-1$）と系 L3（$S_\infty$ 候補点までの距離による上界）の全列挙照合。
- **Step D**: 定理 L4 を**円分体 $\mathbb{Q}(\zeta_{\ell^M})$ での直接付値計算**（cycle 16 `point_val`）と照合。
  同時に定理 B′ を「一意 / tie だが当たる / **tie で外す**」の 3 通りに分けて件数を出す。
- **Step E**（`theorem_k_prime.sage`）: 定理 K′（無仮定版）を母集団で Matrix–Tree 定理による
  塔の値と照合し、**cycle 19 が tie で予言を出さなかった塔が何個埋まるか**を測る。
  $\ell\in\{2,3\}$ のみ（cycle 19 で $\ell=5,7$ は tie 0 件なので新規に埋まる塔が無い）。
- **Step F**: $\ell=2$ トーラスの $\Theta_M$。cycle 19 §5.4 が報告した「真値 $\Theta_3=44$ に対し
  定理 B′ の和は $40$」を再現し、定理 L4 が $44$ を出すことを示す。
- **Step G**: 敵対的レビュー。G1 $\binom cs$ 行列の可逆性、G2「L1 は J4 と同じ下界を返しているだけでは？」、
  G3 再帰の停止（sep の最大値）、G4 「$E$ が消える点を黙って飛ばしていないか」。

## 限界（結論の射程外）

- 母集団は cycle 19 と同じ 430 個（bouquet 2–3 ループ 210 個 ＋ 2 頂点 3 重辺 220 個、voltage 9 種＋自明）で、
  $d=2$ に限る。母集団の外（$d\ge3$、頂点数の多いグラフ、大きい voltage、大きい $\ell$）については何も主張しない。
- 定理 L1・L4 は本文に**有限個の例に依らない証明**がある。数値はその照合である。
  数値支持どまりの主張は report §7 に隔離してある。
- **定理 L1 が潰すのは定理 J4 の打ち消しであって、定理 B′ の tie ではない**（別の障害）。
  後者を潰すのは定理 L4 である。この 2 つを混同しないこと（report §6 に経緯を書いた）。
- **Step E の $\ell=3$ は母集団を走査しきっていない。** 壁時計上限 1500 秒で
  先頭 252/430 個まで（未実施 178 個、すべて 2 頂点 3 重辺の族）。
  cycle 19 が tie で落とした $\ell=3$ の 165 個のうち測れたのは 99 個であり、残り 66 個は測っていない。
  $\ell=2$ は母集団全数（174/174）を走査している。詳細は [RESULTS.md](RESULTS.md) の「打ち切った計算」。

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle20_T3_cancellation
sage cancellation.sage    > cancellation.out    2>&1
sage theorem_k_prime.sage > theorem_k_prime.out 2>&1
```

Step ごとの実数値は [RESULTS.md](RESULTS.md)、生ログは `*.out`。
