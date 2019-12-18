# doble - The javadoc tool
# By: Evan Pratten <ewpratten@retrylife.ca>

use 5.010;
use strict;
use warnings;

# Handle CLI flags
my ($mode, $setting) = @ARGV;

# Ensure we actually have flags
if (not defined $mode){
    print "No program arguments specified. \nUse one of -l (local) or -p (publish) to specify mode.\n";
    exit 1;
} else {
    print "Starting doble\n";
}

# No matter the mode, we must build the documentation first
print "Building javadoc\n";
system("./gradlew javadoc --console=plain");

print "Injecting javascript search bugfix\n";
system("sed -i 's/useModuleDirectories/false/g' build/reports/docs/search.js");

# Handle local hosting
if ($mode eq "-l"){
    print("Starting local javadoc server\n");
    print("This will move to the documentation directory\n");
    
    # Move to docs directory
    chdir "./build/reports/docs";

    # Start http server
    system("python -m SimpleHTTPServer 5806");

}