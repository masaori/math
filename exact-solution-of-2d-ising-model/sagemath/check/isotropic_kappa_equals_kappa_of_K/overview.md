# SageMath Check: isotropic_kappa_equals_kappa_of_K

## 対象

**対象ラベル**: `isotropic_kappa_equals_kappa_of_K`

- ファイル: `structured-latex/content/critical_point_and_log_divergence.ts`
- ブロック: `critical_point_claim_isotropic_kappa_equals_kappa_of_K`（等方な場合 κ = κ(K)）
- 範囲: 準備 K_2^* = K^* の鎖（左辺→1 行目から 2→3 行目までの 3 つの等号）、κ の鎖（左辺→1 行目から 3→4 行目までの 4 つの等号）、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 左辺→1 行目 K_2^* = −(1/2)log(tanh K_2)（`def_second_dual_coupling_constant`） | `check_lines_generic.sage` | 定義の書き写しなので検算の対象が無い（ログに NOT CHECKED と出す） | 確かめていない | — |
| 準備 1→2 行目 = −(1/2)log(tanh K)（K_2 = K） | 同上 | u_2 = exp(−2K_2)、u = exp(−2K) の `QQ(u_2,u)` で log の引数 tanh K_2 と tanh K が、代入 u_2 = u で一致し、代入しないと一致しない | **PASS** | 厳密 |
| 準備 2→3 行目 = K^*（`def_isotropic_dual_coupling`） | 同上 | 定義の式と一致。形の一致のみ | **PASS** | 形の一致のみ |
| κ の鎖 左辺→1 行目 κ = 2K_1 − 2K_2^*（`def_kappa`） | 同上 | `QQ` 上の 6 変数の多項式環で、差が def_kappa の 1 本で生成するイデアルに入り、その 1 本を抜いてほかの 3 本を残すと入らない | **PASS** | 厳密 |
| κ の鎖 1→2 行目 = 2K − 2K_2^*（K_1 = K） | 同上 | 同じ判定を K_1 = K の 1 本で | **PASS** | 厳密 |
| κ の鎖 2→3 行目 = 2K − 2K^*（準備） | 同上 | 同じ判定を K_2^* = K^* の 1 本で | **PASS** | 厳密 |
| κ の鎖 3→4 行目 = κ(K)（`def_isotropic_kappa_of_K`） | 同上 | 同じ判定を κ(K) の定義の 1 本で | **PASS** | 厳密 |
| 主張 κ = κ(K) | `check_lines_generic.sage` | 4 本の関係式のもとで κ − κ(K) がイデアルに入る。鎖の各行の具体値（`check_lines_with_balls.sage`）は K_1 = K_2 = K と置くので同じ値の照合のみ | **PASS** | 厳密 |
| 追加の確認（主張の外） | `check_lines_with_balls.sage` | 具体値 K ∈ {1/10, 1/5, 2/5, 4407/10000, 1/2, 1, 3/2} で K^* > 0（def_isotropic_dual_coupling の値域）、exp(−2K^*) = tanh K、κ(K) ≠ 0（K_c ≈ 0.44069 の近くでも確定）。対照: K^* の符号を誤ると κ(K) と一致しない | **PASS** | ボール（真偽の確認 77 件、うち対照 7 件） |

## 計算の帰属と範囲

- **厳密**: 準備は tanh x = (1 − exp(−2x))/(1 + exp(−2x)) で tanh を `QQ(u_2,u)` の元にし、log は関数なので引数の等号で比べる（この書き換えは本文の証明には無い）。
  仮定 K_2 = K は exp の単射性から u_2 = u と同じなので、代入で表す。κ の鎖は多項式環のイデアルの所属で判定する。
- **ℝ への脱出（`RealBallField(256)`）**: tanh の値が実数の exp の値、K_2^*・K^* が実対数の値なので、具体値の確認だけに使う。tanh K は本文の exp のボール
  （`body_real_exp_ball`）から作り、log は Arb の log を使う。判定の決まりは `sagemath/_shared/isotropic_balls.sage`。

## 確かめられない行と理由

- 準備 1→2 行目の「K_2 = K なので log(tanh K_2) = log(tanh K)」は関数への代入であり、多項式のイデアルでは表せないので、有理関数体の代入で確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh isotropic_kappa_equals_kappa_of_K
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
