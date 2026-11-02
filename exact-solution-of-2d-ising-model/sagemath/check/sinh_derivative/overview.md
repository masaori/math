# SageMath Check: sinh_derivative

## 対象

**対象ラベル**: `sinh_derivative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sinh_derivative`（sinh' = cosh）
- 範囲: 鎖の九行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1・2 行目 sinh = ½(exp - exp∘n)、定数倍 | `check_proof_lines.sage` | 形式冪級数の項ごとの微分で（全次数 D 以下の部分の微分は、導関数の全次数 D-1 以下の部分） | **PASS** | 成り立つ |
| 3 行目 和 | `check_proof_lines.sage` | 同じく形式冪級数で | **PASS** | 成り立つ |
| 4 行目 合成 (exp∘n)' = exp'(n(x))·n'(x) | `check_proof_lines.sage` | 形式冪級数で全次数 13 以下 | **PASS** | 成り立つ |
| 5・6 行目 exp' = exp を 2 箇所へ、n(x) = -x | `check_proof_lines.sage` | 形式冪級数で全次数 13 以下 | **PASS** | 成り立つ |
| 7 行目 n' = -1（定数倍と恒等関数の導関数 1） | `check_proof_lines.sage` | QQ[x] の微分で | **PASS** | 成り立つ |
| 8・9 行目 四則、cosh の定義 | `check_proof_lines.sage` | 形式冪級数で。対照として sinh' ≠ sinh。両端は SR の記号微分でも一致 | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sinh_derivative
```

実行ログは `logs/` に保存する。
