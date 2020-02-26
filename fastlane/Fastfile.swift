// This file contains the fastlane.tools configuration
// You can find the documentation at https://docs.fastlane.tools
//
// For a list of all available actions, check out
//
//     https://docs.fastlane.tools/actions
//

import Foundation

class Fastfile: LaneFile {
	func betaLane() {
	desc("Push a new beta build to TestFlight")
		let newBuildNumber = incrementBuildNumber(xcodeproj: "Eleve.xcodeproj")
        let versionNumber = getVersionNumber(xcodeproj: "Eleve.xcodeproj")
        let changeLog = changelogFromGitCommits(between: "\(lastGitTag()),HEAD")

		buildApp(scheme: "Eleve")

        
        // Add to git, commit and push
        gitAdd()
        let commitMessage =
        """
        New build for TestFlight ✈️ \(versionNumber)b\(newBuildNumber)
        
        Changelog:
        \(changeLog)
        """
        sh(command: "git commit -S -m \"\(commitMessage)\"")
        pushToGitRemote(localBranch: gitBranch())
        addGitTag(buildNumber: "\(versionNumber)b\(newBuildNumber)")
        pushToGitRemote(localBranch: gitBranch())
        
		uploadToTestflight(username: "marek@marekpridal.eu", teamId: "118755174")
	}
}
