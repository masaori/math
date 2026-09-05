/**
 * 研究監督の記録（`docs/tasks/supervision-log.jsonl`）の受理規則。
 *
 * ここは**純関数だけ**を持つ。ファイルシステムへ触れる判定（対象の実在）は呼び出し側から
 * 関数として受け取る。規則とディスクの判定を分けるのは、規則の側だけを検査しても、
 * 実在判定がディレクトリやプロジェクト外を真と答えれば「実在する対象」の主張が空のまま
 * 通ってしまうためである（段取りの検査 `structured-latex/tools/roadmap-rules.ts` で
 * 一度その穴が実際に見つかっている）。
 *
 * 契約の正本は `docs/tasks/supervision-runbook.md`。この規則はその契約のうち、
 * 機械が判定できる部分だけを写したものであり、契約を緩める向きに書き換えてはならない。
 */

/** 監督の対象が実在するかの判定。ラベルなら本文に、パスならプロジェクト内の通常ファイルとして。 */
export type TargetResolver = {
  readonly labelExists: (label: string) => boolean;
  readonly fileExists: (path: string) => boolean;
};

export const goalVerdicts = ["整合", "逸脱"] as const;
export const roadmapVerdicts = ["妥当", "要変更"] as const;
export const adoptions = ["採用", "棄却", "保留"] as const;

/** 記録 1 行が持つ違反。空配列なら受理。 */
export type Violation = { readonly where: string; readonly why: string };

const isObject = (value: unknown): value is Record<string, unknown> =>
  typeof value === "object" && value !== null && !Array.isArray(value);

const isNonEmptyString = (value: unknown): value is string =>
  typeof value === "string" && value.trim() !== "";

/** 空文字を許す文字列（反例・不変量のように「無い」が正当な欄）。 */
const isStringOrEmpty = (value: unknown): value is string => typeof value === "string";

const isNonEmptyStringArray = (value: unknown): value is readonly string[] =>
  Array.isArray(value) && value.length > 0 && value.every(isNonEmptyString);

/**
 * ISO 8601 の日時で、実際の時刻として解釈できること。
 * 形だけの文字列（`"いつか"`）や、存在しない日付を通さない。
 */
const parseInstant = (value: unknown): number | null => {
  if (typeof value !== "string") return null;
  const match = /^(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})([+-]\d{2}:\d{2}|Z)$/.exec(value);
  if (match === null) return null;
  const parsed = Date.parse(value);
  if (Number.isNaN(parsed)) return null;
  // `Date.parse` は存在しない日付（2 月 30 日など）を翌月へ繰り上げて受理する。
  // 日付の各成分を UTC 側で組み直し、繰り上がっていないことを確かめる。
  const [, year, month, day, hour, minute, second, zone] = match;
  const offsetMinutes =
    zone === "Z"
      ? 0
      : (zone.startsWith("-") ? -1 : 1) *
        (Number(zone.slice(1, 3)) * 60 + Number(zone.slice(4, 6)));
  const rebuilt = new Date(parsed + offsetMinutes * 60_000);
  const same =
    rebuilt.getUTCFullYear() === Number(year) &&
    rebuilt.getUTCMonth() + 1 === Number(month) &&
    rebuilt.getUTCDate() === Number(day) &&
    rebuilt.getUTCHours() === Number(hour) &&
    rebuilt.getUTCMinutes() === Number(minute) &&
    rebuilt.getUTCSeconds() === Number(second);
  return same ? parsed : null;
};

const checkTarget = (
  target: unknown,
  resolve: TargetResolver,
  where: string,
  violations: Violation[],
): void => {
  if (!isObject(target)) {
    violations.push({ where, why: "対象がオブジェクトではない" });
    return;
  }
  const kind = target["種別"];
  const name = target["名前"];
  if (!isNonEmptyString(name)) {
    violations.push({ where, why: "対象の名前が空である" });
    return;
  }
  if (kind === "ラベル") {
    if (!resolve.labelExists(name)) {
      violations.push({ where, why: `対象のラベルが本文に実在しない: ${name}` });
    }
    return;
  }
  if (kind === "パス") {
    if (!resolve.fileExists(name)) {
      violations.push({
        where,
        why: `対象のパスがプロジェクト内の通常ファイルとして実在しない: ${name}`,
      });
    }
    return;
  }
  violations.push({ where, why: `対象の種別が「ラベル」でも「パス」でもない: ${String(kind)}` });
};

const checkIteration = (
  iteration: unknown,
  index: number,
  resolve: TargetResolver,
  violations: Violation[],
): void => {
  const where = `反復[${index}]`;
  if (!isObject(iteration)) {
    violations.push({ where, why: "反復がオブジェクトではない" });
    return;
  }
  checkTarget(iteration["対象"], resolve, `${where}.対象`, violations);

  for (const key of ["仮説", "インサイト", "次の探索への接続"]) {
    if (!isNonEmptyString(iteration[key])) {
      violations.push({ where: `${where}.${key}`, why: `${key} が空である` });
    }
  }
  for (const key of ["反例", "不変量"]) {
    if (!isStringOrEmpty(iteration[key])) {
      violations.push({ where: `${where}.${key}`, why: `${key} が文字列ではない（無いなら空文字）` });
    }
  }

  const adoption = iteration["採否"];
  if (typeof adoption !== "string" || !(adoptions as readonly string[]).includes(adoption)) {
    violations.push({ where: `${where}.採否`, why: `採否が ${adoptions.join(" / ")} のいずれでもない` });
    return;
  }
  // 棄却は反例に支えられていなければならない。反例を書かずに棄却できると、
  // 「うまくいかなかったので捨てた」が根拠のない記録として残り、あとから再検討できない。
  if (adoption === "棄却" && !isNonEmptyString(iteration["反例"])) {
    violations.push({ where: `${where}.反例`, why: "採否が「棄却」なのに反例が空である" });
  }
};

const checkRoadmapChange = (
  change: unknown,
  resolve: TargetResolver,
  violations: Violation[],
): void => {
  const where = "段取りの変更";
  if (!isObject(change)) {
    violations.push({ where, why: "段取りの変更がオブジェクトではない" });
    return;
  }
  const changed = change["変更した"];
  if (typeof changed !== "boolean") {
    violations.push({ where: `${where}.変更した`, why: "変更したが真偽値ではない" });
    return;
  }
  if (!changed) {
    // 変えていない回でも、なぜ変えなくてよいと判断したかは残す。
    if (!isNonEmptyString(change["変更しない理由"])) {
      violations.push({ where: `${where}.変更しない理由`, why: "段取りを変えなかった理由が空である" });
    }
    return;
  }
  if (!isNonEmptyString(change["差分"])) {
    violations.push({ where: `${where}.差分`, why: "段取りを変えたのに差分が空である" });
  }
  const evidence = change["証拠"];
  if (!Array.isArray(evidence) || evidence.length === 0) {
    violations.push({ where: `${where}.証拠`, why: "段取りを変えたのに証拠が空である" });
    return;
  }
  evidence.forEach((item, index) => {
    checkTarget(item, resolve, `${where}.証拠[${index}]`, violations);
  });
};

const checkVerdict = (
  value: unknown,
  allowed: readonly string[],
  where: string,
  violations: Violation[],
): void => {
  if (!isObject(value)) {
    violations.push({ where, why: "判定がオブジェクトではない" });
    return;
  }
  const verdict = value["判定"];
  if (typeof verdict !== "string" || !allowed.includes(verdict)) {
    violations.push({ where: `${where}.判定`, why: `判定が ${allowed.join(" / ")} のいずれでもない` });
  }
  if (!isNonEmptyString(value["根拠"])) {
    violations.push({ where: `${where}.根拠`, why: "判定の根拠が空である" });
  }
};

/** 記録 1 行の違反を全て返す。空配列なら受理。 */
export const violationsOfEntry = (entry: unknown, resolve: TargetResolver): readonly Violation[] => {
  const violations: Violation[] = [];
  if (!isObject(entry)) return [{ where: "記録", why: "記録がオブジェクトではない" }];

  if (parseInstant(entry["実施時刻"]) === null) {
    violations.push({ where: "実施時刻", why: "実施時刻が ISO 8601 の日時ではない" });
  }

  const scope = entry["監督対象の範囲"];
  if (!isObject(scope)) {
    violations.push({ where: "監督対象の範囲", why: "監督対象の範囲がオブジェクトではない" });
  } else {
    if (!isNonEmptyStringArray(scope["確認した節"])) {
      violations.push({ where: "監督対象の範囲.確認した節", why: "確認した節が空である" });
    }
    if (!isNonEmptyStringArray(scope["確認した成果コミット"])) {
      violations.push({
        where: "監督対象の範囲.確認した成果コミット",
        why: "確認した成果コミットが空である",
      });
    }
  }

  checkVerdict(entry["最終ゴールとの照合"], goalVerdicts, "最終ゴールとの照合", violations);
  checkVerdict(entry["段取りの妥当性"], roadmapVerdicts, "段取りの妥当性", violations);

  const iterations = entry["反復"];
  if (!Array.isArray(iterations) || iterations.length === 0) {
    violations.push({ where: "反復", why: "反復が空である（監督は必ず対象範囲の反復を列挙する）" });
  } else {
    iterations.forEach((iteration, index) => checkIteration(iteration, index, resolve, violations));
  }

  checkRoadmapChange(entry["段取りの変更"], resolve, violations);

  if (!isNonEmptyString(entry["次の監督までの申し送り"])) {
    violations.push({ where: "次の監督までの申し送り", why: "次の監督までの申し送りが空である" });
  }

  return violations;
};

/**
 * 記録全体の違反を返す。行ごとの規則に加えて、時刻が単調非減少であることを要求する。
 * 順序が崩れた記録は「直前の監督以降」という対象範囲の定義が意味を失うため受理しない。
 */
export const violationsOfLog = (
  entries: readonly unknown[],
  resolve: TargetResolver,
): readonly Violation[] => {
  const violations: Violation[] = [];
  if (entries.length === 0) {
    return [{ where: "記録", why: "記録が 1 行も無い（設置しただけで一度も回っていない）" }];
  }
  entries.forEach((entry, index) => {
    for (const violation of violationsOfEntry(entry, resolve)) {
      violations.push({ where: `${index + 1} 行目 / ${violation.where}`, why: violation.why });
    }
  });

  let previous: number | null = null;
  entries.forEach((entry, index) => {
    const instant = isObject(entry) ? parseInstant(entry["実施時刻"]) : null;
    if (instant === null) return;
    if (previous !== null && instant < previous) {
      violations.push({ where: `${index + 1} 行目 / 実施時刻`, why: "実施時刻が前の行より前へ戻っている" });
    }
    previous = instant;
  });

  return violations;
};
