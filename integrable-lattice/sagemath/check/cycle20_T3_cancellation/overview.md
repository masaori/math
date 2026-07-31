# cycle 20 / T3 Pure: 打ち消し（$|J(r)|\ge2$）の数値検証 — 対象ラベル

対応する証明本体: [`outputs/reports/cycle20_T3_cancellation_recursion.md`](../../../outputs/reports/cycle20_T3_cancellation_recursion.md)

## 対象ラベル（論文本文のブロック）

| ラベル | 本検証が支える内容 |
|---|---|
| `paper_prop_R` | 桁枝再帰による消滅深度の決定（(R1)–(R3)）と、終結式による付値・予言アルゴリズムの無仮定化（(R4)(R5)）。本検証の Step A–G が全項目に対応する |

`paper_prop_J`（命題 J）の限界リスト第 1 項（打ち消しで $\theta$ が決まらない）は
命題 R の (R2) で解消されるが、**命題 J のブロックは編集していない**（並行作業との衝突回避）。
関係は命題 R 側から `paper_prop_J` を参照して書いてある。

## 検証する命題（証明本体との対応）

| 証明本体の番号 | 論文の項番号 | 内容 | Step |
|---|---|---|---|
| 補題 L0 / L0′ | (R1) | $\overline{\Phi}=\sum_c(1+x)^cg_c(x^\ell)$、$\mathbb{F}_\ell[[x]]$ は $\mathbb{F}_\ell[[x^\ell]]$ 上階数 $\ell$ の自由加群 | A |
| 定理 L1 | (R2) | $\theta=\ell d+s^*$、$s^*\le\ell-1$ は必ず存在する（打ち消しは起きない） | A, B, G1, G2 |
| 系 L2 | (R3) | $\theta\le\ell^{\mathrm{sep}}-1$（鋭い）。補題 J9 の量的な別証明 | C, G3 |
| 系 L3 | (R3) | $\theta(P)<\ell^{1+g^{\max}}/\mathrm{dist}(P,U)$。系 J3 のコンパクト性を有効な上界へ | C |
| 定理 L4 | (R4) | $\hat\theta_M=v_\ell(\mathrm{Res}_x(\Psi_M,\Phi))$。定理 B′ の一意性仮定が不要 | D, F, G4 |
| 定理 K′ | (R5) | $\mathrm{ord}_\ell(\kappa_n)$ が仮定なしに整数計算で決まる | E |
| report §6.1 | — | cycle 19 が落としていた 174/165 個は**定理 B′ の tie** が原因で、定理 J4 の打ち消しではない | D, E, F |

## 先行サイクルとの関係

- cycle 19 step 1（[`cycle19_T3_theta_ge_ell_plus_1.md`](../../../outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md)、
  検証は [`../cycle19_T3_theta_ge_ell/`](../cycle19_T3_theta_ge_ell/)）の §7.1 が残した障害が対象である。
  定理 J4・定理 B′・定理 K・補題 J9・系 J3・系 J10 はそちらが正本で、本検証はそれらを**更新**する
  （何がどう更新されるかは report §9 の表）。
- cycle 19 step 2（[`cycle19_T3_theta_infinity.md`](../../../outputs/reports/cycle19_T3_theta_infinity.md)）の
  閉形式（定理 X′）には触れていない。本サイクルが与えたのは「値を決める手続き」であって「値の形」ではない。

## 実行

```bash
cd integrable-lattice/sagemath/check/cycle20_T3_cancellation
sage cancellation.sage    > cancellation.out    2>&1
sage theorem_k_prime.sage > theorem_k_prime.out 2>&1
```

詳細（手順・限界）は [README.md](README.md)、Step ごとの実数値は [RESULTS.md](RESULTS.md)。

## 実行ステータスと結果

両スクリプトとも**完走**した（詳細は [RESULTS.md](RESULTS.md)）。

| スクリプト | 状態 | FAIL 件数 | 打ち切り | 所要 |
|---|---|---|---|---|
| `cancellation.sage`（Step A–D・F–H） | **完走** | **0** | **0 件** | 177.7s |
| `theorem_k_prime.sage`（Step E） | **完走** | **0** | **1 件**（$\ell=3$ で 178 個未実施） | 1585.2s |

主な数値:

- Step A: 定理 L1 = $\overline{\Phi}$ の位数の直接計算を **102900 点**で照合、**全一致**（未実施 0）。
- Step B: cycle 19 §7.1 の tie の層は L1 ですべて決まった（決まらなかったもの 0 件）。
- Step C: 系 L2・L3 の破れ 0 件。Step D: 定理 L4 = 円分体での直接付値計算が
  $\ell=2$ で 1187 点、$\ell=3$ で 928 点、$\ell=5$ で 2133 点**全一致**。
- Step F: $\ell=2$ トーラスで定理 L4 が $\Theta_3=44$、$\Theta_4=108$（真値と一致。定理 B′ の和は 40, 96）。
- Step H: 系 L3′ の上界の破れ 0 件（上界は緩く、鋭さは主張しない）。
- Step E: 下表。

| $\ell$ | 走査した塔 | cycle 19 が tie で落としていた塔 | **K′ が予言でき一致** | cycle 19 でも予言できていた塔 | 一致 | (H) 等で除外 | **時間切れ未実施** |
|---|---|---|---|---|---|---|---|
| 2 | 174 | 174 | **174** | 0 | 0 | 256 | **0** |
| 3 | 192 | 99 | **99** | 93 | 93 | 60 | **178** |

## 打ち切り（結論の射程が狭まる範囲）

**Step E の $\ell=3$ で壁時計上限 1500 秒を超過し、母集団 430 個のうち先頭 252 個までで停止した
（未実施 178 個）。** 未実施分はすべて 2 頂点 3 重辺の族である（bouquet 210 個は全数処理済み、
2 頂点 3 重辺 220 個のうち処理したのは先頭 42 個）。cycle 19 の $\ell=3$ の内訳（tie 165 / 除外 172）と
突き合わせると、未実施 178 個は **cycle 19 が tie で落としていた塔 66 個 ＋ (H) 等で除外される塔 112 個**である。

したがって、

- 「cycle 19 が tie で落とした塔が定理 K′ で埋まる」という測定は、
  $\ell=2$ では**母集団全数（174/174）**、$\ell=3$ では **165 個中 99 個（60%）**にとどまる。
- $\ell=3$ の測定は **bouquet 族に偏っている**（2 頂点 3 重辺の族は 220 個中 42 個のみ）。
- 未実施は「測っていない」ことを意味する。走査した範囲での不一致（FAIL）は 0 件である。
