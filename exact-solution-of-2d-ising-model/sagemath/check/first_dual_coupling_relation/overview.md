# SageMath Check: first_dual_coupling_relation

## 対象

**対象ラベル**: `first_dual_coupling_relation`

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- ブロック: `transfer_matrix_000j_claim_first_dual_coupling_relation`（第一の結合定数と双対結合定数の双対関係 `sinh(2K_1)sinh(2K_1^*) = 1`）
- 範囲: 証明の全行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 冒頭の六つの含意（`cosh K_1 > sinh K_1 > 0`、`sinh K_1, cosh K_1 ≠ 0`、積 ≠ 0、`0 < tanh K_1 < 1`、`tanh K_1 ∈ ℝ_{>0}`、`tanh K_1 ≠ 0`） | `check_nonzero_denominators.sage` | `K_1 = log q` の 6 点で `QQ`、`K_1 ∈ QQ` の 7 点で本文の exp のボール | **PASS** | 成り立つ |
| `K_1^* = -(1/2)L`、`2K_1^* = -L`、`-2K_1^* = L`（`L := log(tanh K_1)`） | `check_dual_coupling_exponentials.sage` | `QQ[L]` で厳密に | **PASS** | 成り立つ |
| `exp(-L)tanh K_1 = exp(-L)exp(L) = exp(-L+L) = exp(0) = 1` | `check_dual_coupling_exponentials.sage` | 最初の等号は有理関数体で根拠 `tanh K_1 = exp(L)` だけを代入して（代入しなければ等しくないことも見る）、残りは `QQ[l]` の形式冪級数（全次数 14 まで）で厳密に | **PASS** | 成り立つ |
| `exp(-L) = 1/tanh K_1`（両辺を `tanh K_1 ≠ 0` で割る） | `check_dual_coupling_exponentials.sage` | 有理関数体で `X - 1/T = (XT - 1)(1/T)`、つまり仮定 `XT = 1` のもとで結論が従うことを厳密に | **PASS** | 成り立つ |
| `exp(2K_1^*) = exp(-L) = 1/tanh K_1`、`exp(-2K_1^*) = exp(L) = tanh K_1` | — | 等しい実数へ exp を当てる行・直前の等式の置換・`exp(log y) = y` そのもので、計算を含まない（下の「範囲外のもの」） | — | — |
| `sinh(2K_1^*)` の鎖の 4 つの等号 | `check_dual_sinh_chain.sage` | 有理関数体で、各行の根拠の関係（`exp(2K_1^*) = 1/T` など）だけを代入して隣の行と一致。代入しなければ一致しないことも見る。両端を 13 点のボール | **PASS** | 成り立つ |
| 倍角の鎖の 5 つの等号 | `check_double_angle_chain.sage` | 有理関数体で同様に。代入した `exp(±K)^2 = exp(±2K)` は形式冪級数で。両端を 6 点で `QQ`、7 点でボール | **PASS** | 成り立つ |
| 最後の鎖の 8 つの等号 | `check_product_chain.sage` | 有理関数体で同様に。最後の行 `(cosh K_1)² - (sinh K_1)² = 1` は定義どおりの式で `exp(K)exp(-K)` が残り、それを 1 にする関係を形式冪級数で | **PASS** | 成り立つ |
| 主張 `sinh(2K_1)sinh(2K_1^*) = 1` | `check_claim.sage` | 鎖を通らず定義から直接作った両辺。`K_1 = log q` の 6 点と `K_1 ∈ QQ` の 7 点のボールが 1 を含む。`K_1^*` を 2 倍に取り違えた値では 1 を含まないことも見る | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は、証明に現れる実数（`exp(±K_1)`、`exp(±2K_1)`、`tanh K_1`、`exp(±2K_1^*)`、`sinh(2K_1)`、`sinh(2K_1^*)`）を独立な不定元に置いた `QQ` 上の有理関数体で確かめた。各行の差を、その行の根拠が述べる関係だけを代入して 0 にする（`_prelude.sage` の `line_step`）。代入した exp の関係は形式冪級数で別に確かめた。`K_1 = log q`（`q ∈ QQ`、`q > 1`）の点は `exp(K_1) = q` なので、`sinh K_1`・`cosh K_1`・`tanh K_1`・`sinh(2K_1)` と大小は `QQ` で判定した。
- **`ℝ` への脱出（`RealBallField(512)`）**: 大小の行、主張、および鎖の両端を具体の点で見るときだけ使う。実対数の値と `exp(±2K_1^*)`、および `K_1 ∈ QQ` の点の exp の値は `QQ` に収まらない。exp は本文の部分和に尾の評価を半径として足したボール（Arb の exp は使わない）、log は有理数の端点で挟んだ区間（`sagemath/_shared/positive_coupling_and_real_log.sage` の `real_log_enclosure`。端点が log を挟むことは本文の exp のボールで確かめる）。許容誤差は置かず、重なり・包含で判定する。判定が中身を持つよう、比べたボールの幅の上限を見る（主張は 2^-40 未満。主張の幅は `K_1 = 30` で `sinh(60) ≈ 10^26` が log の区間の余白 2^-130 を増幅した分で、実測で最悪 2^-44）。

範囲外のもの: 選んだ以外の点。集合への所属だけを述べる推論（`ℝ_{>0}` の定義、正の元は零でない、体であること）は、計算を含まないので、値が `QQ` かボールで 0 を含まずに作れたことを見るだけである。`exp(2K_1^*) = exp(-L)`・`exp(-2K_1^*) = exp(L)`（等しい実数へ exp を当てる）、`= 1/tanh K_1`（直前の等式の置換）、`exp(L) = tanh K_1`（`exp(log y) = y`）は計算を含まない。これらを具体の点のボールで比べても、log を挟む区間が `exp(lo) < y < exp(hi)` で作られているので作り方から通り、何も確かめないため比べない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh first_dual_coupling_relation
```

実行ログは `logs/` に保存する。共通の準備は `_prelude.sage` と `sagemath/_shared/positive_coupling_and_real_log.sage`。
