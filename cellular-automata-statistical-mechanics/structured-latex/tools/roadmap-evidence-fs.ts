/**
 * 段取りの根拠が指すパスの実在を、ディスクの上で判定する。
 *
 * 規則そのもの（`roadmap-rules.ts`）は純関数で持ち、ここだけがファイルシステムに触れる。
 * 判定を `existsSync` 一行で書くと、ディレクトリが「実在する根拠」として通る。ディレクトリは
 * 中身が空でも存在するため、それを根拠と認めると実在の主張が空になる。根拠は一次情報そのもの
 * （通常ファイル）を指していなければならない。
 */

import { statSync } from "node:fs";
import { isAbsolute, relative, resolve } from "node:path";

/** `projectDir` からの相対パスが、`projectDir` の内側に通常ファイルとして実在するか。 */
export const evidenceFileExists = (projectDir: string, path: string): boolean => {
  const absolute = resolve(projectDir, path);
  const inside = relative(resolve(projectDir), absolute);
  if (inside === "" || inside.startsWith("..") || isAbsolute(inside)) return false;
  try {
    return statSync(absolute).isFile();
  } catch {
    return false;
  }
};
