# SageMath Check: cosh_derivative

## 対象

**対象ラベル**: `cosh_derivative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_cosh_derivative`（cosh' = sinh）
- 範囲: 鎖の九行と主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1・2 行目 cosh = ½(exp + exp∘n)、定数倍 | `check_proof_lines.sage` | 形式冪級数の項ごとの微分で（全次数 D 以下の部分の微分は、導関数の全次数 D-1 以下の部分） | **PASS** | 成り立つ |
| 3 行目 和 | `check_proof_lines.sage` | 同じく形式冪級数で | **PASS** | 成り立つ |
| 4 行目 合成 (exp∘n)' = exp'(n(x))·n'(x) | `check_proof_lines.sage` | 形式冪級数で全次数 13 以下 | **PASS** | 成り立つ |
| 5・6 行目 exp' = exp を 2 箇所へ、n(x) = -x | `check_proof_lines.sage` | 形式冪級数で全次数 13 以下 | **PASS** | 成り立つ |
| 7 行目 n' = -1（定数倍と恒等関数の導関数 1） | `check_proof_lines.sage` | QQ[x] の微分で | **PASS** | 成り立つ |
| 8・9 行目 四則、sinh の定義 | `check_proof_lines.sage` | 形式冪級数で。対照として cosh' ≠ cosh、cosh' ≠ −sinh。両端は SR の記号微分でも一致 | **PASS** | 成り立つ |
| 主張 cosh'(x) = sinh x | `check_proof_lines.sage` | x ∈ {−2, −1/3, 0, 1/5, 3/2} で差分商 (cosh(x+h) − cosh x)/h（h = 2^{−10}, 2^{−20}, 2^{−30}）と sinh x の差が h·cosh(|x|+1)/2 以下 | **PASS** | ボール |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ[x]` の形式冪級数（全次数 14 以下）で確かめた（`sagemath/_shared/hyperbolic_by_definition.sage`）。
- **`ℝ` への脱出（`RealBallField(512)`）**: 主張の具体の点だけ。cosh・sinh の値は本文の exp の部分和に尾の評価を半径として足したボールで、Arb の exp は使わない。
  差分商の誤差の上限 h·cosh(|x|+1)/2 はテイラーの剰余の評価で、検算の側で使う標準の事実である（本文には無い）。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh cosh_derivative
```

実行ログは `logs/` に保存する。
