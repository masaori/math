# SageMath Check: isotropic_gamma_in_kappa

## 対象

**対象ラベル**: `isotropic_gamma_in_kappa`

- ファイル: `structured-latex/content/critical_point_and_log_divergence.ts`
- ブロック: `critical_point_claim_isotropic_gamma_in_kappa`（等方な場合 γ(θ) = 2 arcsinh(√(sinh²(κ(K)/2) + sin²(θ/2))^(ℝ≥0))）
- 範囲: γ(θ) から始まる 4 行の鎖（左辺→1 行目から 3→4 行目までの 4 つの等号）と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 左辺→1 行目（`gamma_kappa_identity` の第 3 式） | `check_lines_with_balls.sage` | γ(θ) を主張の式を使わずに def_gamma1_gamma2_of_theta と def_gamma_theta から作り、第 3 式の右辺（A を残す）と重なる。第 3 式そのものの証明の行は `sagemath/check/gamma_kappa_identity/` が確かめる | **PASS** | ボール |
| 1→2 行目（`isotropic_A_equals_one`） | `check_lines_generic.sage` | 根号の中身 X + A·Y と X + 1·Y の差が A − 1 の 1 本で生成するイデアルに入り、抜くと 0 でない。具体値は A = 1 を入れた同じ形の値の照合のみ | **PASS** | 厳密 |
| 2→3 行目（1·x = x） | 同上 | 多項式の等号。具体値は同じ値の照合のみ | **PASS** | 厳密 |
| 3→4 行目（`isotropic_kappa_equals_kappa_of_K`） | 同上 | sinh² の引数 κ/2 と κ(K)/2 の差が κ − κ(K) の 1 本で生成するイデアルに入り、抜くと 0 でない。具体値は κ と κ(K) を同じ式 2K − 2K^* から作るので同じ値の照合のみ | **PASS** | 厳密 |
| 主張 | `check_lines_with_balls.sage` | K ∈ {1/10, 1/5, 2/5, 4407/10000, 1/2, 1, 3/2} と θ = πr（r ∈ {0, 1/7, 1/3, 1/2, 1, 3/2, −2/5}）で、定義から作った γ(θ) が 2 arcsinh(√(sinh²(κ(K)/2) + sin²(θ/2))) と重なる。対照: 異方的（K_2 = K + 1/3）では A を落とした式は γ と一致せず、A を残すと一致する | **PASS** | ボール（真偽の確認 357 件、うち対照 7 件） |

## 計算の帰属と範囲

- **厳密**: √·^(ℝ≥0)・arcsinh・sinh²(·/2) は関数なので、各行を根号の中身と sinh² の引数の等号として `QQ` 上の多項式環のイデアルの所属で判定する。
- **ℝ への脱出（`RealBallField(256)`）**: sinh・cosh・tanh の値が実数の exp の値、K^* が実対数の値、sin・cos・arccosh・arcsinh・√ の値も実数なので、
  具体値の確認だけに使う。sinh 2K・cosh 2K・tanh K は本文の exp のボール（`body_real_exp_ball`）から作る。K^* は `QQ` に無いので sinh 2K^*・cosh 2K^* は
  Arb の関数を使う。cos θ・sin(θ/2) は Arb の cos・sin を使う（本文に全実数上の cos・sin が未整備のため）。arccosh・arcsinh は本文の定義
  log(y + √(y² ∓ 1)) から作り、Arb の arcsinh と重なることも確かめた。判定の決まりは `sagemath/_shared/isotropic_balls.sage`。

## 確かめられない行と理由

- 左辺→1 行目は上流の主張の適用なので、ここでは具体値で γ と右辺が重なることだけを確かめる。
- 値の等号（√ と arcsinh を施した後）は厳密には扱わず、引数の等号を厳密に、値を具体値で確かめる。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh isotropic_gamma_in_kappa
```

`sage` が PATH に無いときは `~/micromamba/envs/sage/bin/sage` を PATH に足す。実行ログは `logs/` に保存する。
