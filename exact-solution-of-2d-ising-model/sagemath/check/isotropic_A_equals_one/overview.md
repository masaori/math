# SageMath Check: isotropic_A_equals_one

## 対象

**対象ラベル**: `isotropic_A_equals_one`

- ファイル: `structured-latex/content/critical_point_and_log_divergence.ts`
- ブロック: `critical_005_claim_isotropic_setting`（等方な場合 K_1 = K_2 = K で A = 1）
- 範囲: 左辺 A から 1 までの 4 行の鎖（左辺→1 行目から 3→4 行目までの 4 つの等号）と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 左辺→1 行目 A = s_1s_2^*（`def_critical_sinh_product_A`） | `check_lines_generic.sage` | 模型の A をこの式で作るので、形の一致のみ。具体値も同じ値の照合のみ | **PASS** | 形の一致のみ |
| 1→2 行目 = sinh 2K_1 sinh 2K_2^*（`def_indexed_hyperbolic_abbreviations`） | 同上 | 略記の展開。形の一致のみ。具体値も同じ値の照合のみ | **PASS** | 形の一致のみ |
| 2→3 行目 = sinh 2K_2 sinh 2K_2^*（K_1 = K = K_2） | 同上 | u_1 = exp(−2K_1)、u_2 = exp(−2K_2) の `QQ(u_1,u_2)` で、仮定 u_1 = u_2 を代入すると一致し、代入しないと一致しない。具体値は K_1 = K_2 = K と置くので同じ値の照合のみ | **PASS** | 厳密 |
| 3→4 行目 = 1（`second_dual_coupling_relation`） | 両方 | exp(−2K_2^*) = tanh K_2（`def_second_dual_coupling_constant`）から sinh 2K_2 sinh 2K_2^* が `QQ(u_2)` で恒等的に 1。具体値 7 点で 1 と重なる。対照: K_2^* の符号を誤ると積は −1 | **PASS** | 厳密・ボール |
| 主張 A = 1 | 両方 | `QQ(u_1,u_2)` で u_1 = u_2 のとき A = 1、A − 1 は恒等的には 0 でない（異方的なら成り立たない）。具体値 K ∈ {1/10, 1/5, 2/5, 4407/10000, 1/2, 1, 3/2} で A と 1 が重なり、対照として異方的（K_2 = K + 1/3）・符号を誤った K_2^* で A ≠ 1 | **PASS** | 厳密・ボール（真偽の確認 63 件、うち対照 14 件） |

## 計算の帰属と範囲

- **厳密**: tanh x = (1 − exp(−2x))/(1 + exp(−2x))、sinh 2x = (exp(2x) − exp(−2x))/2 の書き換えで、行を `QQ(u_1,u_2)` の元にする。
  この書き換えは本文の証明には無く、検算の側で使う標準の恒等式である。仮定 K_1 = K_2 は exp の単射性から u_1 = u_2 と同じなので、代入で表す。
- **ℝ への脱出（`RealBallField(256)`）**: sinh・tanh の値が実数の exp の値（部分和の極限）、K_2^* が実対数の値なので、具体値の確認だけに使う。
  K は `QQ` に取り、sinh 2K・tanh K は本文の exp を囲むボール（`body_real_exp_ball`）から作る。K_2^* は `QQ` に無いので log・sinh 2K_2^* は Arb の関数を使い、
  sinh 2K_2^* が (1/tanh K_2 − tanh K_2)/2 と重なることも確かめた。判定の決まりは `sagemath/_shared/isotropic_balls.sage`（許容誤差なし。
  等号は重なりと差の半径 2^{-100} 未満、不等号はボールが 0 を含まないこと。どちらにも決まらなければ失敗）。

## 確かめられない行と理由

- 2→3 行目の「K_1 = K_2 なので sinh 2K_1 = sinh 2K_2」は関数への代入であり、多項式のイデアルでは表せないので、有理関数体の代入で確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh isotropic_A_equals_one
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
