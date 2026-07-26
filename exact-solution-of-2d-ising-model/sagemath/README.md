# sagemath/ — 数値検証

証明本体（`structured-latex/content/`）の主張を、SageMath で数値的に再確認する。
**ここは証明ではない。** 反例を見つけるための独立な検算であり、証明の代わりにはならない。
逆に、ここで不一致が出たら本文か検証コードのどちらかが誤っている、という強い信号になる。

## ディレクトリ構成

```
sagemath/
├── README.md                  # このファイル
├── _shared/
│   ├── defs.sage              # symbolic な gamma_1, gamma_2, A(theta), a(theta) などの式
│   └── operators.sage         # Mat(2,C)^{⊗M} を具体的な 2^M × 2^M 行列として構成する
├── check/<NNN>_<対象>/
│   ├── overview.md            # **必須。この check の README を兼ねる**
│   ├── check_NN_*.sage        # 検証コード（1ファイル1論点）
│   └── logs/check_NN_*.log    # 実行ログ（実際に走らせた出力をそのまま保存する）
└── tools/
    ├── verify-check-linkage.ts  # 検証 ↔ 証明 の対応を機械検証
    └── run-all-checks.sh         # 全 check を実行してログを更新する
```

## overview.md の必須要件

`tools/verify-check-linkage.ts` は各 check ディレクトリの `overview.md` に

```
**対象ラベル**: `<label>`
```

の行があること、かつそのラベルが `structured-latex/content/` に実在することを検査する。
**この行が無い、またはラベルが実在しないと検証が exit 1 で落ちる。**

`overview.md` にはさらに次を書く（この文書が各 check の README を兼ねる）。

- 対象ブロックのファイル名とブロック id、検証した範囲
- チェック一覧の表（ファイル名 / 検証内容 / ステータス / 結果）
- 数値許容誤差とその根拠（既定と変えた場合は必ず理由を書く）
- 実行方法

## 2 つの共有ライブラリの使い分け

| ファイル | 何を提供するか | 使いどころ |
| --- | --- | --- |
| `_shared/defs.sage` | SageMath の**記号式**としての `gamma_1(θ)`, `gamma_2(θ)`, `A(θ)`, `a(θ)`, `arg^{[0,2π)}`, 本プロジェクト定義の `sqrt`、および `numerical_check()` | 2×2 のスカラー式レベルの恒等式 |
| `_shared/operators.sage` | `Mat(2,C)^{⊗M}` の元を**具体的な 2^M × 2^M の複素行列**（クロネッカー積）として構成する。`Zop`, `Yop`, `eps_op`, `V1_op`, `V2_op`, `H1_op`, `H2_op`, `hatZ_op`, `hatY_op`, `psi_ops`, `T_conj`, `comm`, `acomm` など。数値は numpy の complex128、行列指数は `scipy.linalg.expm` | 作用素の等式・反交換関係・共役作用・固有値 |

`operators.sage` は記号計算を使わない。`2^M × 2^M` の行列指数を扱う必要があるためである。
本プロジェクトのゴール設定（[README](../README.md)）が「具体的なクロネッカー積で書く」ことを
要求しているので、検証側も同じ具体度で書く。

### 符号の規約（重要）

複号 `∓` は `sign` 引数（`'+'` / `'-'`）で表す。`_mp_sign('+') = -1`, `_mp_sign('-') = +1`。
これは本文の `H_1^{(±)} := Y_1Z_2 + … + Y_{M-1}Z_M ∓ Y_M Z_1` と
`hatZ^{(±)}_μ`（`j=1` の重みが `∓1`）に合わせたものである。

## CheckReport の使い方

```python
rep = CheckReport("何を検証しているか")
rep.close(lhs, rhs, "ラベル")   # 行列/スカラーの一致（成分最大値で正規化した相対誤差）
rep.truth(bool_value, "ラベル") # 真偽値
rep.finish()                    # PASS/FAIL を出力。FAIL なら exit 1
```

`close` は**相対**誤差で比べる。`cosh(2K_1)` が `1e8` 規模になるパラメータがあるため、
絶対誤差で比べると倍精度の丸めで落ちてしまうからである。

## 実行

```bash
# 単体
sage sagemath/check/<dir>/check_01_....sage

# 全部（ログも更新する）
bash sagemath/tools/run-all-checks.sh

# 検証 ↔ 証明 の対応
node sagemath/tools/verify-check-linkage.ts
```

## 不一致が出たときの扱い

**本文（`structured-latex/content/`）を勝手に直さない。**
どの式がどのパラメータで合わないかを、実行ログ（一次情報）とともに `MEMORY.md` に記録する。
本文の修正は、原因が数学的に確定してから別途行う。
