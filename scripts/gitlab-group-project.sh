#!/bin/bash

# Configuration
GITLAB_URL="https://git.shinoshike.studio"
GITLAB_TOKEN="glpat-xBEAzy-73hWdWatMxCqd"

# Function to create a group
create_group() {
    local group_name="$1"
    local group_path="${group_name// /-}"
    local description="$2"
    
    echo "Creating group: $group_name"
    
    curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
         --header "Content-Type: application/json" \
         --data "{
           \"name\": \"$group_name\",
           \"path\": \"$group_path\",
           \"description\": \"$description\",
           \"visibility\": \"private\"
         }" \
         --request POST "${GITLAB_URL}/api/v4/groups"
    
    return $?
}

# Function to create a project within a group
create_project() {
    local group_id="$1"
    local project_name="$2"
    local project_path="${project_name// /-}"
    
    echo "Creating project: $project_name in group ID: $group_id"
    
    curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
         --header "Content-Type: application/json" \
         --data "{
           \"name\": \"$project_name\",
           \"path\": \"$project_path\",
           \"namespace_id\": \"$group_id\",
           \"visibility\": \"private\"
         }" \
         --request POST "${GITLAB_URL}/api/v4/projects"
    
    return $?
}

# Main execution
main() {
    # Read inputs
    # read -p "Enter group name: " group_name
    # read -p "Enter group description: " group_description
    # read -p "Enter project name: " project_name
    
    # Create group and store response
    group_response=$(create_group "$group_name" "$group_description")
    group_id=$(echo $group_response | grep -o '"id":[0-9]*' | cut -d':' -f2)
    
    if [ -z "$group_id" ]; then
        echo "Failed to create group"
        exit 1
    fi
    
    # Create project in the group
    create_project "$group_id" "$project_name"
    
    echo "Setup complete!"
}

main "$@"