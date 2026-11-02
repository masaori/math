# SageMath Check: sinh_zero

## 対象

**対象ラベル**: `sinh_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`
- ブロック: `critical_claim_sinh_zero`（sinh 0 = 0）
- 範囲: 鎖の四行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 1 行目 sinh の定義を 0 へ | `check_proof_lines.sage` | exp(0), exp(-0) を不定元に置いて | **PASS** | 成り立つ |
| 2 行目 -0 = 0 | `check_proof_lines.sage` | QQ の等号。対照として不定元のままでは 1 行目と 2 行目は一致しない | **PASS** | 成り立つ |
| 3 行目 exp(0) = 1（scalar_exp_zero）を 2 箇所へ | `check_proof_lines.sage` | 部分和 S_N([0]) の成分が N = 0,…,30 で 1 | **PASS** | 成り立つ |
| 4 行目 四則 | `check_proof_lines.sage` | QQ で厳密。ボールでも sinh 0 が 0 を含む | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: 等号の行は `QQ` 上の多項式環・有理関数体・剰余環、関数体 `QQ(y)[s]/(s²-y²-1)`、`AA`・`QQbar`、形式冪級数（全次数 14 以下）で確かめた。
- **`ℝ` への脱出（`RealBallField(512)`）**: 不等号の行と主張の点での確認だけ。exp の値が `QQ` に収まらないためである。ボールは本文の exp の部分和に尾の評価を半径として足したもの（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）で、Arb の exp は使わない。arcsinh の値を囲むときだけ Arb の `log`・`sqrt` を使う（本文の log は exp の逆写像で、本文の exp は標準の exp に等しいため）。
- **構成上かならず一致する比較**: 定義を当てはめる行（例えば 1 行目の「cosh の定義」）は、左辺を定義の関数から、右辺を本文の式のまま作って比べており、定義の書き写しの誤りだけを検出する。

範囲外のもの:

- 選んだ以外の点と、全次数 14 を超える項。微分の公式・(R3)・(R4) そのもの（本文が外部から持ち込む実数解析の事実）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh sinh_zero
```

実行ログは `logs/` に保存する。
